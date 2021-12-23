require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	ignore_ft_on_setup = {},
	auto_close = true,
	open_on_tab = false,
	diagnostics = {
		enable = false,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = false,
		update_cwd = false,
		ignore_list = {},
	},
	view = {
		width = 30,
		height = 30,
		side = "left",
		auto_resize = true,
		mappings = {
			custom_only = false,
			list = {},
		},
	},
})
