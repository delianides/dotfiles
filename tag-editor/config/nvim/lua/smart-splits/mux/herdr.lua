-- smart-splits.nvim multiplexer backend for herdr (https://herdr.dev).
--
-- smart-splits ships backends for tmux/wezterm/kitty/zellij only. It resolves
-- them with `require("smart-splits.mux." .. multiplexer_integration)`, so this
-- file just has to sit on the runtimepath under that module path. Adding one
-- module here does not shadow the plugin: Lua's searcher resolves per module,
-- not per directory, and every other `smart-splits.*` path is absent here.
--
-- herdr injects HERDR_PANE_ID into every pane it spawns; that is both our
-- session check and the id we use to address our own pane.
--
-- Every herdr CLI command prints one JSON object on stdout, shaped
-- `{ "id": ..., "result": { "<key>": {...}, "type": "..." } }`.

local utils = require("smart-splits.utils")
local log = require("smart-splits.log")

---@type SmartSplitsMultiplexer
local M = {} ---@diagnostic disable-line: missing-fields

---@diagnostic disable-next-line: assign-type-mismatch
M.type = "herdr"

---@return string
local function herdr_bin()
  local bin = vim.env.HERDR_BIN_PATH
  if bin and #bin > 0 then
    return bin
  end
  return "herdr"
end

---The pane Neovim itself is running in.
---@return string|nil
local function own_pane_id()
  local pane_id = vim.env.HERDR_PANE_ID
  if pane_id and #pane_id > 0 then
    return pane_id
  end
  return nil
end

---Run a herdr CLI command and decode its response.
---@param args string[]
---@return table|nil result the decoded `result` object, or nil on any failure
local function herdr_exec(args)
  if not own_pane_id() then
    return nil
  end

  -- utils.system raises if the binary is missing from $PATH.
  local ok, text, code = pcall(utils.system, vim.list_extend({ herdr_bin() }, args))
  if not ok then
    log.debug("herdr: %s", text)
    return nil
  end
  if code ~= 0 or not text or #text == 0 then
    log.debug("herdr: `%s` exited %s: %s", table.concat(args, " "), tostring(code), text)
    return nil
  end

  local decoded_ok, decoded = pcall(vim.json.decode, text)
  if not decoded_ok or type(decoded) ~= "table" then
    log.debug("herdr: could not decode response: %s", text)
    return nil
  end
  return decoded.result
end

function M.is_in_session()
  return own_pane_id() ~= nil
end

---The pane herdr currently has focused.
---
---This deliberately reports the *focused* pane rather than our own. smart-splits
---calls this before and after `next_pane` and compares the two to decide whether
---the move landed; our own id would never change and every move would look like
---a failure.
---
---Note this reads `pane layout`, not `pane current` — with HERDR_PANE_ID set,
---`pane current` resolves to *our* pane and so never reflects a focus change.
---@return string|nil
function M.current_pane_id()
  local result = herdr_exec({ "pane", "layout" })
  if not result or not result.layout then
    return nil
  end
  return result.layout.focused_pane_id
end

function M.current_pane_at_edge(direction)
  local pane_id = own_pane_id()
  if not pane_id then
    return false
  end

  local result = herdr_exec({ "pane", "edges", "--pane", pane_id })
  if not result or not result.edges then
    return false
  end
  -- `edges` is keyed by the same left/right/up/down names smart-splits uses.
  return result.edges[direction] == true
end

function M.current_pane_is_zoomed()
  local result = herdr_exec({ "pane", "layout" })
  if not result or not result.layout then
    return false
  end
  return result.layout.zoomed == true
end

function M.next_pane(direction)
  local pane_id = own_pane_id()
  if not pane_id then
    return false
  end

  local result = herdr_exec({ "pane", "focus", "--pane", pane_id, "--direction", direction })
  if not result or not result.focus then
    return false
  end
  -- `changed` is false (reason "no_neighbor") when there is no pane that way.
  return result.focus.changed == true
end

---herdr's `pane resize --amount` is a fraction of the containing tab, but
---smart-splits passes an amount in cells. Convert against the tab's area.
---@param direction SmartSplitsDirection
---@param amount number cells
---@return number|nil
local function cells_to_ratio(direction, amount)
  local result = herdr_exec({ "pane", "layout" })
  local area = result and result.layout and result.layout.area
  if not area then
    return nil
  end

  local total = (direction == "left" or direction == "right") and area.width or area.height
  if not total or total <= 0 then
    return nil
  end
  return amount / total
end

function M.resize_pane(direction, amount)
  local pane_id = own_pane_id()
  if not pane_id then
    return false
  end

  local ratio = cells_to_ratio(direction, amount)
  if not ratio then
    return false
  end

  local result = herdr_exec({
    "pane",
    "resize",
    "--pane",
    pane_id,
    "--direction",
    direction,
    "--amount",
    tostring(ratio),
  })
  return result ~= nil
end

function M.split_pane(direction, size)
  local pane_id = own_pane_id()
  if not pane_id then
    return false
  end

  -- herdr only splits "right" or "down"; left/up land on the same axis.
  local split_direction = (direction == "left" or direction == "right") and "right" or "down"
  local args = { "pane", "split", "--pane", pane_id, "--direction", split_direction }
  if size then
    table.insert(args, "--ratio")
    table.insert(args, tostring(size))
  end

  local result = herdr_exec(args)
  M.update_mux_layout_details()
  return result ~= nil
end

function M.update_mux_layout_details()
  -- herdr resolves layout server-side on every call, so there is nothing to cache.
end

return M
