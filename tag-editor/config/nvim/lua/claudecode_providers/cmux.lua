-- Terminal provider for claudecode.nvim that opens Claude in a new cmux pane
-- below the current one and reuses that pane for follow-up sends. Only active
-- when Neovim is running inside a cmux surface (CMUX_WORKSPACE_ID is set).

local M = {}

local function run(args)
  local out = vim.fn.system(args)
  return out, vim.v.shell_error
end

local function env_prefix(env_table)
  local parts = {}
  for k, v in pairs(env_table or {}) do
    table.insert(parts, k .. "=" .. vim.fn.shellescape(tostring(v)))
  end
  return table.concat(parts, " ")
end

function M.new()
  local workspace = vim.env.CMUX_WORKSPACE_ID
  local state = { surface = nil, pane = nil }

  local function pane_alive()
    if not state.pane then
      return false
    end
    local out, code = run({ "cmux", "list-panes", "--workspace", workspace })
    if code ~= 0 then
      return false
    end
    return out:find(state.pane, 1, true) ~= nil
  end

  local function focus()
    if state.pane then
      run({ "cmux", "focus-pane", "--workspace", workspace, "--pane", state.pane })
    end
  end

  local function spawn(cmd_string, env_table, cwd)
    local out, code = run({ "cmux", "new-pane", "--direction", "down", "--workspace", workspace })
    if code ~= 0 then
      vim.notify("cmux provider: new-pane failed: " .. out, vim.log.levels.ERROR)
      return
    end
    state.surface = out:match("(surface:%d+)")
    state.pane = out:match("(pane:%d+)")
    if not state.surface then
      vim.notify("cmux provider: could not parse new-pane output: " .. out, vim.log.levels.ERROR)
      return
    end
    local prefix = env_prefix(env_table)
    local cd = (cwd and cwd ~= "") and ("cd " .. vim.fn.shellescape(cwd) .. " && ") or ""
    local line = cd .. (prefix ~= "" and (prefix .. " ") or "") .. cmd_string
    run({ "cmux", "send", "--workspace", workspace, "--surface", state.surface, line })
    run({ "cmux", "send-key", "--workspace", workspace, "--surface", state.surface, "Enter" })
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
    if state.surface then
      run({ "cmux", "close-surface", "--workspace", workspace, "--surface", state.surface })
    end
    state.surface = nil
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

  -- The cmux pane is always on screen once created, so visibility is a no-op.
  function P.ensure_visible() end

  function P.is_available()
    return vim.env.CMUX_WORKSPACE_ID ~= nil
  end

  return P
end

return M
