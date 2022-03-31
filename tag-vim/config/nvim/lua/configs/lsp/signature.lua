local M = {}

function M.config()
  local status_ok, lsp_signature = pcall(require, "lsp_signature")
  if not status_ok then
    return
  end

  lsp_signature.setup()
end

return M
