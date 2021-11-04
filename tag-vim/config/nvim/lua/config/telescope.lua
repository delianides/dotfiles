local trouble = require("trouble.providers.telescope")
local harpoon = require("harpoon.mark")
local telescope = require("telescope")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local themes = require("telescope.themes")

local set_prompt_to_entry_value = function(prompt_bufnr)
	local entry = action_state.get_selected_entry()
	if not entry or not type(entry) == "table" then
		return
	end

	action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

telescope.setup({
	defaults = {
		prompt_prefix = "❯ ",
		selection_caret = " ",

		winblend = 0,

		layout_strategy = "horizontal",

		selection_strategy = "reset",
		sorting_strategy = "descending",
		scroll_strategy = "cycle",
		color_devicons = true,

		mappings = {
			i = {
				["<C-t>"] = trouble.open_with_trouble,
				["<C-h>"] = harpoon.add_file,
			},
		},
	},

	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
		fzf_writer = {
			use_highlighter = false,
			minimum_grep_characters = 6,
		},
	},
})

telescope.load_extension("git_worktree")
telescope.load_extension("fzy_native")

local M = {}

M.project_files = function(opts)
	opts = opts or {}

	local _git_pwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

	if vim.v.shell_error ~= 0 then
		local client = vim.lsp.get_active_clients()[1]
		if client then
			opts.cwd = client.config.root_dir
		end
		require("telescope.builtin").find_files(opts)
		return
	end

	require("telescope.builtin").git_files(opts)
end

M.edit_zsh = function()
	require("telescope.builtin").find_files({
		shorten_path = false,
		cwd = "~/.zsh/",
		prompt = "~ zsh ~",
		hidden = true,
		follow = true,

		layout_strategy = "horizontal",
		layout_config = {
			preview_width = 0.55,
		},
	})
end

M.edit_neovim = function()
	local opts_with_preview, opts_without_preview

	opts_with_preview = {
		prompt_title = "~ dotfiles ~",
		shorten_path = false,
		cwd = "~/.config/nvim",
		follow = true,

		layout_strategy = "flex",
		layout_config = {
			width = 0.9,
			height = 0.8,

			horizontal = {
				width = { padding = 0.15 },
			},
			vertical = {
				preview_height = 0.75,
			},
		},

		attach_mappings = function(_, map)
			map("i", "<c-y>", set_prompt_to_entry_value)
			map("i", "<M-c>", function(prompt_bufnr)
				actions.close(prompt_bufnr)
				vim.schedule(function()
					require("telescope.builtin").find_files(opts_without_preview)
				end)
			end)

			return true
		end,
	}

	opts_without_preview = vim.deepcopy(opts_with_preview)
	opts_without_preview.previewer = false

	require("telescope.builtin").find_files(opts_with_preview)
end

M.git_status = function()
	local opts = themes.get_dropdown({
		winblend = 10,
		border = true,
		previewer = false,
		shorten_path = false,
	})

	-- Can change the git icons using this.
	-- opts.git_icons = {
	--   changed = "M"
	-- }

	require("telescope.builtin").git_status(opts)
end

M.git_commits = function()
	require("telescope.builtin").git_commits({
		winblend = 5,
	})
end

M.git_branches = function()
	require("telescope.builtin").git_branches({
		attach_mappings = function(_, map)
			map("i", "<c-d>", actions.git_delete_branch)
			map("n", "<c-d>", actions.git_delete_branch)
		end,
	})
end

local util = require("util")

util.nnoremap("<C-f>", M.project_files)
util.nnoremap("<Leader>fd", function()
	require("telescope.builtin").git_files({ cwd = "~/.dotfiles" })
end)

util.cmap("<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", { noremap = false, nowait = true })

return M
