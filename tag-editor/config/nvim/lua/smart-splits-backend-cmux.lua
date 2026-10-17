-- smart-splits.nvim backend for cmux (https://cmux.com), implementing the
-- smart-splits backend protocol v3 (see PROTOCOL.md in smart-splits.nvim).
-- Selected with `mux = { backend = "smart-splits-backend-cmux" }`.
--
-- cmux injects CMUX_WORKSPACE_ID into every terminal it spawns; that is both
-- our session check and the workspace we address.
--
-- Unlike tmux, cmux has no directional focus command -- `focus-pane`
-- takes a pane ref. What it does expose is `list-panes --json`, where every
-- pane carries a `pixel_frame` (x/y/width/height in points, y growing
-- downwards). So neighbours and edges are computed here from that geometry.
-- `bin/cmux-nav` in the shell dotfiles runs the same algorithm for zsh; keep
-- the two in step.
--
-- Caveat: cmux only populates pixel_frame for the *visible* workspace; a
-- background workspace reports zeros. Zero-sized frames are dropped, so a
-- background workspace can never produce a bogus neighbour.

local log = require("smart-splits.log")

---@type SmartSplitsBackend
local M = {
  name = "cmux",
  protocol_version = "^3.0.0",
}

---Points of slack when deciding whether two frames touch, to absorb the
---divider cmux draws between panes.
local TOUCH_TOLERANCE = 4

---Cells to resize by when core passes no amount.
local DEFAULT_RESIZE_AMOUNT = 3

---Milliseconds to wait on any single cmux CLI call.
local TIMEOUT = 500

local OPPOSITE = { left = "right", right = "left", up = "down", down = "up" }

---@return string
local function cmux_bin()
  for _, candidate in ipairs({ vim.env.CMUX_BIN_PATH, vim.env.CMUX_BUNDLED_CLI_PATH }) do
    if candidate and #candidate > 0 then
      return candidate
    end
  end
  return "cmux"
end

---The workspace Neovim itself is running in.
---@return string|nil
local function workspace_id()
  local workspace = vim.env.CMUX_WORKSPACE_ID
  if workspace and #workspace > 0 then
    return workspace
  end
  return nil
end

---Run a cmux CLI command scoped to our workspace.
---@param args string[]
---@return string|nil stdout, or nil on any failure
local function cmux_exec(args)
  local workspace = workspace_id()
  if not workspace then
    return nil
  end

  local argv = { cmux_bin() }
  vim.list_extend(argv, args)
  vim.list_extend(argv, { "--workspace", workspace })

  -- vim.system raises if the binary is missing from $PATH.
  local ok, result = pcall(function()
    return vim.system(argv, { text = true, timeout = TIMEOUT }):wait()
  end)
  if not ok then
    log.debug("cmux: %s", result)
    return nil
  end
  if result.code ~= 0 then
    log.debug("cmux: `%s` exited %s: %s", table.concat(args, " "), tostring(result.code), result.stderr or "")
    return nil
  end
  return result.stdout or ""
end

---@class CmuxPane
---@field ref string
---@field focused boolean
---@field x number
---@field y number
---@field width number
---@field height number
---@field cell_width number points per column
---@field cell_height number points per row

---Every pane in our workspace that currently has a real frame on screen.
---@return CmuxPane[]|nil
local function panes()
  local text = cmux_exec({ "list-panes", "--json" })
  if not text or #text == 0 then
    return nil
  end

  local ok, decoded = pcall(vim.json.decode, text)
  if not ok or type(decoded) ~= "table" or type(decoded.panes) ~= "table" then
    log.debug("cmux: could not decode list-panes: %s", text)
    return nil
  end

  local result = {}
  for _, pane in ipairs(decoded.panes) do
    local frame = pane.pixel_frame
    if frame and (frame.width or 0) > 0 and (frame.height or 0) > 0 then
      table.insert(result, {
        ref = pane.ref,
        focused = pane.focused == true,
        x = frame.x,
        y = frame.y,
        width = frame.width,
        height = frame.height,
        cell_width = pane.cell_width_points or 0,
        cell_height = pane.cell_height_points or 0,
      })
    end
  end
  return result
end

---@param list CmuxPane[]
---@return CmuxPane|nil
local function focused_pane(list)
  for _, pane in ipairs(list) do
    if pane.focused then
      return pane
    end
  end
  return nil
end

---How far `other` sits past our edge, and how much of the shared border the two
---panes have in common. A negative gap means they overlap.
---@param me CmuxPane
---@param other CmuxPane
---@param direction SmartSplitsDirection
---@return number gap, number overlap
local function gap_and_overlap(me, other, direction)
  if direction == "left" or direction == "right" then
    local gap = direction == "right" and (other.x - (me.x + me.width)) or (me.x - (other.x + other.width))
    local overlap = math.min(other.y + other.height, me.y + me.height) - math.max(other.y, me.y)
    return gap, overlap
  end

  local gap = direction == "down" and (other.y - (me.y + me.height)) or (me.y - (other.y + other.height))
  local overlap = math.min(other.x + other.width, me.x + me.width) - math.max(other.x, me.x)
  return gap, overlap
end

---The pane `direction` of the focused one. `farthest = false` picks the one cmux
---would land on (nearest, then best aligned); `farthest = true` picks the one at
---the far edge, which is where a wrap from the opposite edge lands.
---@param direction SmartSplitsDirection
---@param farthest boolean
---@return string|nil pane ref
local function pane_towards(direction, farthest)
  local list = panes()
  if not list then
    return nil
  end
  local me = focused_pane(list)
  if not me then
    return nil
  end

  local best, best_gap, best_overlap
  for _, pane in ipairs(list) do
    if pane.ref ~= me.ref then
      local gap, overlap = gap_and_overlap(me, pane, direction)
      -- `gap >= -TOUCH_TOLERANCE` keeps panes starting at (or a hair before)
      -- our edge; `overlap > 0` keeps only panes that share that edge at all.
      if gap >= -TOUCH_TOLERANCE and overlap > 0 then
        local better = not best
          or (farthest and gap > best_gap)
          or (not farthest and gap < best_gap)
          or (gap == best_gap and overlap > best_overlap)
        if better then
          best, best_gap, best_overlap = pane, gap, overlap
        end
      end
    end
  end

  return best and best.ref or nil
end

---@param ref string|nil
---@return boolean
local function focus(ref)
  return ref ~= nil and cmux_exec({ "focus-pane", "--pane", ref }) ~= nil
end

---cmux resizes in points; smart-splits passes an amount in cells. Convert
---against the focused pane's cell metrics.
---@param direction SmartSplitsDirection
---@param amount number cells
---@return number|nil points
local function cells_to_points(direction, amount)
  local list = panes()
  local me = list and focused_pane(list)
  if not me then
    return nil
  end

  local cell = (direction == "left" or direction == "right") and me.cell_width or me.cell_height
  if not cell or cell <= 0 then
    return nil
  end
  return math.max(1, math.floor(amount * cell + 0.5))
end

function M.detect()
  return workspace_id() ~= nil
end

---cmux does not wrap at its own edges, so `opts.at_edge` is honoured here:
---'stop' declines, 'wrap' jumps to the pane at the opposite edge, and 'split'
---opens a new cmux split.
---@param direction SmartSplitsDirection
---@param opts? SmartSplitsBackendMoveOpts
---@return boolean
function M.move(direction, opts)
  opts = opts or {}
  if focus(pane_towards(direction, false)) then
    return true
  end

  if opts.at_edge == "wrap" then
    return focus(pane_towards(OPPOSITE[direction], true))
  elseif opts.at_edge == "split" then
    return cmux_exec({ "new-split", direction, "--focus", "true" }) ~= nil
  end
  return false
end

---@param direction SmartSplitsDirection
---@param opts? SmartSplitsBackendResizeOpts
---@return boolean
function M.resize(direction, opts)
  opts = opts or {}
  local flags = { left = "-L", right = "-R", up = "-U", down = "-D" }
  local flag = flags[direction]
  if not flag then
    return false
  end

  local points = cells_to_points(direction, opts.amount or DEFAULT_RESIZE_AMOUNT)
  if not points then
    return false
  end

  return cmux_exec({ "resize-pane", flag, "--amount", tostring(points) }) ~= nil
end

function M.health()
  if not workspace_id() then
    vim.health.info("not inside cmux (CMUX_WORKSPACE_ID is unset)")
    return
  end
  if vim.fn.executable(cmux_bin()) ~= 1 then
    vim.health.error(("cmux CLI not found: %s"):format(cmux_bin()))
    return
  end
  vim.health.ok(("cmux workspace %s"):format(workspace_id()))
end

return M
