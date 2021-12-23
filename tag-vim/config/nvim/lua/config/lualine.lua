local colors = {
	bg = "#202328",
	fg = "#bbc2cf",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

require("lualine").setup({
	options = {
		theme = "onedark",
		icons_enabled = true,
		section_separators = "",
		component_separators = "",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "filename" },
		lualine_c = {
			"branch",
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " " },
				sections = { "error", "warn", "info" },
				diagnostics_color = {
					error = {
						fg = colors.red,
					},
					warn = {
						fg = colors.yellow,
					},
					info = {
						fg = colors.fg,
					},
				},
			},
		},
		lualine_x = {
			{
				"diff",
				-- Is it me or the symbol for modified us really weird
				symbols = { added = "⊕ ", modified = "⊚ ", removed = "⊖ " },
				color_added = colors.green,
				color_modified = colors.orange,
				color_removed = colors.red,
				condition = conditions.hide_in_width,
			},
		},
		lualine_y = { "filetype" },
		lualine_z = { "location" },
	},
})

-- local Group = require("colorbuddy.group").Group
-- local g = require("colorbuddy.group").groups
-- local s = require("colorbuddy.style").styles
