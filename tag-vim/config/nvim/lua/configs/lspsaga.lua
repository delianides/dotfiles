local M = {}

function M.config()
  local status_ok, saga = pcall(require, "lspsaga")
  if not status_ok then
    return
  end

  saga.init_lsp_saga()
end

return M
