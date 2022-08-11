local M = {}

function M.config()
  local ok, notify = pcall(require, "notify")
  if ok then
    notify.setup({ stages = "fade" })

    vim.notify = notify
  end
end

return M
