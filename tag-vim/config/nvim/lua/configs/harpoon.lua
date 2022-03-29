local M = {}

function M.config()
  local present, harpoon = pcall(require, "harpoon")
  if not present then
    return
  end

  harpoon.setup()
end

return M
