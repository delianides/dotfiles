local M = {}

function M.config(client)
  local status_ok, ts = pcall(require, "nvim-lsp-ts-utils")
  if not status_ok then
    return
  end

  -- vim.lsp.handlers["textDocument/codeAction"] = ts.code_action_handler
  ts.setup {
    debug = false,
    disable_commands = false,
    enable_import_on_completion = false,

    -- update imports on file move
    update_imports_on_move = false,
    require_confirmation_on_move = false,
    watch_dir = nil,

    -- filter diagnostics
    filter_out_diagnostics_by_severity = { "hint" },
    filter_out_diagnostics_by_code = {},
  }

  ts.setup_client(client)
end

return M
