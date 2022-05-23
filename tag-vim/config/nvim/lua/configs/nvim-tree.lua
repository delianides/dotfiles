local M = {}

function M.config()
	local status_ok, nvim_tree = pcall(require, "nvim-tree")
	if not status_ok then
		return
	end

	nvim_tree.setup({
		auto_reload_on_write = true,
		disable_netrw = true,
		hijack_unnamed_buffer_when_opening = true,
		reload_on_bufenter = true,
		log = {
			enable = true,
			truncate = false,
			types = {
				all = true,
			},
		},
	})
end

return M
