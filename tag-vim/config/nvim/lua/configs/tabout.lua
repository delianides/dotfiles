local M = {}

M.config = function()
  local tabout = safe_require("tabout")
  if not tabout then
    return
  end

  tabout.setup({})
end

return M
