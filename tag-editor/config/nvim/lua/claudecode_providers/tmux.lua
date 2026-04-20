-- Terminal provider for claudecode.nvim that opens Claude in a new tmux pane
-- next to the current one and reuses that pane for follow-up sends. Only
-- active when Neovim is running inside tmux ($TMUX is set).

local M = {}

local function run(args)
  local out = vim.fn.system(args)
  return out, vim.v.shell_error
end

local function direction_flags(direction)
  if direction == "up" then
    return { "-v", "-b" }
  elseif direction == "right" then
    return { "-h" }
  elseif direction == "left" then
    return { "-h", "-b" }
  end
  return { "-v" } -- "down" (default)
end

function M.new(opts)
  opts = opts or {}
  local size = opts.size or "40%"
  local direction = opts.direction or "down"
  local state = { pane = nil }

  local function pane_alive()
    if not state.pane then
      return false
    end
    local out, code = run({ "tmux", "list-panes", "-a", "-F", "#{pane_id}" })
    if code ~= 0 then
      return false
    end
    for line in out:gmatch("[^\r\n]+") do
      if line == state.pane then
        return true
      end
    end
    return false
  end

  local function focus()
    if state.pane then
      run({ "tmux", "select-pane", "-t", state.pane })
    end
  end

  local function spawn(cmd_string, env_table, cwd)
    local args = { "tmux", "split-window", "-d" }
    for _, flag in ipairs(direction_flags(direction)) do
      table.insert(args, flag)
    end
    table.insert(args, "-l")
    table.insert(args, size)
    if cwd and cwd ~= "" then
      table.insert(args, "-c")
      table.insert(args, cwd)
    end
    for k, v in pairs(env_table or {}) do
      table.insert(args, "-e")
      table.insert(args, k .. "=" .. tostring(v))
    end
    table.insert(args, "-P")
    table.insert(args, "-F")
    table.insert(args, "#{pane_id}")
    table.insert(args, cmd_string)

    local out, code = run(args)
    if code ~= 0 then
      vim.notify("tmux provider: split-window failed: " .. out, vim.log.levels.ERROR)
      return
    end
    state.pane = out:match("(%%%d+)")
    if not state.pane then
      vim.notify("tmux provider: could not parse pane id from: " .. out, vim.log.levels.ERROR)
    end
  end

  local P = {}

  function P.setup(_) end

  function P.open(cmd_string, env_table, config, _focus)
    if pane_alive() then
      focus()
      return
    end
    local cwd = (config and config.cwd and config.cwd ~= "") and config.cwd or vim.fn.getcwd()
    spawn(cmd_string, env_table, cwd)
  end

  function P.close()
    if state.pane then
      run({ "tmux", "kill-pane", "-t", state.pane })
    end
    state.pane = nil
  end

  function P.simple_toggle(cmd_string, env_table, config)
    if pane_alive() then
      P.close()
    else
      P.open(cmd_string, env_table, config)
    end
  end

  function P.focus_toggle(cmd_string, env_table, config)
    if pane_alive() then
      focus()
    else
      P.open(cmd_string, env_table, config)
    end
  end

  function P.toggle(cmd_string, env_table, config)
    P.focus_toggle(cmd_string, env_table, config)
  end

  function P.get_active_bufnr()
    return nil
  end

  -- The tmux pane is always on screen once created, so visibility is a no-op.
  function P.ensure_visible() end

  function P.is_available()
    return vim.env.TMUX ~= nil
  end

  return P
end

return M
