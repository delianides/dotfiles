local M = {}

function M.config(client)
  if client.resolved_capabilities.document_highlight then
    require("illuminate").on_attach(client)
  end
end

return M
