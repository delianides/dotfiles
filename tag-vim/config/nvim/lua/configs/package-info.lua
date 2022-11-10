local M = {}

function M.config()
  local packageInfo = safe_require("package-info")

  packageInfo.setup()
end

return M
