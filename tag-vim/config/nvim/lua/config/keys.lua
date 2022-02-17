local present, wk = pcall(require, "which-key")

if not present then
	return
end

local util = require("util")

vim.o.timeoutlen = 300

local presets = require("which-key.plugins.presets")
presets.objects["a("] = nil
wk.setup({
	show_help = false,
	triggers = "auto",
	plugins = { spelling = true },
	key_labels = { ["<leader>"] = "SPC" },
})

-- disable macros
util.nmap("q", "<Nop>")

-- deletes in visual
util.vnoremap("X", '"_d')

-- quick escape
util.inoremap("jj", "<ESC>")

-- move faster
util.nnoremap("H", "^")
util.nnoremap("L", "g_")
util.nnoremap("J", "5j")
util.nnoremap("K", "5k")
util.vnoremap("J", "5j")
util.vnoremap("K", "5k")

-- cycle tabs
util.nnoremap("<S-Tab>", ":tabp<CR>")
util.nnoremap("<Tab>", ":tabn<CR>")

-- indent
util.vmap("<", "<gv")
util.vmap(">", ">gv")

-- disable arrow keys
util.inoremap("<Down>", "<NOP>")
util.inoremap("<Up>", "<NOP>")
util.inoremap("<Left>", "<NOP>")
util.inoremap("<Right>", "<NOP>")
util.nnoremap("<Left>", ':echoe "Use h"<CR>')
util.nnoremap("<Right>", ':echoe "Use l"<CR>')
util.nnoremap("<Up>", ':echoe "Use k"<CR>')
util.nnoremap("<Down>", ':echoe "Use j"<CR>')

-- Add move line shortcuts
util.nnoremap("<A-j>", ":m .+1<CR>==")
util.nnoremap("<A-k>", ":m .-2<CR>==")
util.inoremap("<A-j>", "<Esc>:m .+1<CR>==gi")
util.inoremap("<A-k>", "<Esc>:m .-2<CR>==gi")
util.vnoremap("<A-j>", ">+1<CR>gv=gv")
util.vnoremap("<A-k>", "<-2<CR>gv=gv")

util.nnoremap("<c-t>", ':lua require("FTerm").toggle()<CR>')
util.tmap("<c-t>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

local leader = {
	["w"] = {
		name = "+windows",
		["w"] = { "<C-W>p", "other-window" },
		["d"] = { "<C-W>c", "delete-window" },
		["-"] = { "<C-W>s", "split-window-below" },
		["|"] = { "<C-W>v", "split-window-right" },
		["2"] = { "<C-W>v", "layout-double-columns" },
		["h"] = { "<C-W>h", "window-left" },
		["j"] = { "<C-W>j", "window-below" },
		["l"] = { "<C-W>l", "window-right" },
		["k"] = { "<C-W>k", "window-up" },
		["H"] = { "<C-W>5<", "expand-window-left" },
		["J"] = { ":resize +5", "expand-window-below" },
		["L"] = { "<C-W>5>", "expand-window-right" },
		["K"] = { ":resize -5", "expand-window-up" },
		["="] = { "<C-W>=", "balance-window" },
		["s"] = { "<C-W>s", "split-window-below" },
		["v"] = { "<C-W>v", "split-window-right" },
	},
	b = {
		name = "+buffer",
		["b"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
		["p"] = { "<cmd>:BufferLineCyclePrev<CR>", "Previous Buffer" },
		["["] = { "<cmd>:BufferLineCyclePrev<CR>", "Previous Buffer" },
		["n"] = { "<cmd>:BufferLineCycleNext<CR>", "Next Buffer" },
		["]"] = { "<cmd>:BufferLineCycleNext<CR>", "Next Buffer" },
		["d"] = { "<cmd>:bd<CR>", "Delete Buffer" },
		["g"] = { "<cmd>:BufferLinePick<CR>", "Goto Buffer" },
	},
	g = {
		name = "+git",
		g = { "<cmd>Neogit<CR>", "NeoGit" },
		l = {
			function()
				require("util").float_terminal("lazygit")
			end,
			"LazyGit",
		},
		c = { "<Cmd>Telescope git_commits<CR>", "commits" },
		b = { "<Cmd>Telescope git_branches<CR>", "branches" },
		s = { "<Cmd>Telescope git_status<CR>", "status" },
		d = { "<cmd>DiffviewOpen<cr>", "DiffView" },
		h = { name = "+hunk" },
	},
	["h"] = {
		name = "+help",
		t = { "<cmd>:Telescope builtin<cr>", "Telescope" },
		c = { "<cmd>:Telescope commands<cr>", "Commands" },
		h = { "<cmd>:Telescope help_tags<cr>", "Help Pages" },
		m = { "<cmd>:Telescope man_pages<cr>", "Man Pages" },
		k = { "<cmd>:Telescope keymaps<cr>", "Key Maps" },
		s = { "<cmd>:Telescope highlights<cr>", "Search Highlight Groups" },
		l = { [[<cmd>TSHighlightCapturesUnderCursor<cr>]], "Highlight Groups at cursor" },
		f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
		o = { "<cmd>:Telescope vim_options<cr>", "Options" },
		a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
		p = {
			name = "+packer",
			p = { "<cmd>PackerSync<cr>", "Sync" },
			s = { "<cmd>PackerStatus<cr>", "Status" },
			i = { "<cmd>PackerInstall<cr>", "Install" },
			c = { "<cmd>PackerCompile<cr>", "Compile" },
		},
	},
	u = { "<cmd>UndotreeToggle<CR>", "Undo Tree" },
	s = {
		name = "+search",
		g = { "<cmd>Telescope live_grep<cr>", "Grep" },
		b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
		s = {
			function()
				require("telescope.builtin").lsp_document_symbols({
					symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module" },
				})
			end,
			"Goto Symbol",
		},
		h = { "<cmd>Telescope command_history<cr>", "Command History" },
		m = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
		r = { "<cmd>lua require('spectre').open()<CR>", "Replace (Spectre)" },
	},
	f = {
		name = "+file",
		t = { "<cmd>NvimTreeToggle<cr>", "NvimTree" },
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		n = { "<cmd>enew<cr>", "New File" },
		z = "Zoxide",
		d = "Dot Files",
	},
	m = {
		name = "+markdown",
		p = { "<cmd>MarkdownPreview<cr>", "Markdown Preview" },
		g = { "<cmd>Glow<cr>", "Markdown Glow" },
	},
	p = {
		name = "+project",
		["a"] = { '<cmd>lua require("harpoon.mark").add_file()<CR>', "Add File to Harpoon" },
		["e"] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', "Show Harpoon Files" },
		["n"] = { '<cmd>lua require("harpoon.ui").nav_next()<CR>', "Nav Next Harpooned File" },
		["p"] = { '<cmd>lua require("harpoon.ui").nav_prev()<CR>', "Nav Prev Harpooned File" },
	},
	t = {
		name = "+toggle",
		f = {
			require("config.lsp.formatting").toggle,
			"Format on Save",
		},
		s = {
			function()
				util.toggle("spell")
			end,
			"Spelling",
		},
		w = {
			function()
				util.toggle("wrap")
			end,
			"Word Wrap",
		},
		n = {
			function()
				util.toggle("relativenumber", true)
				util.toggle("number")
			end,
			"Line Numbers",
		},
	},
	["<tab>"] = {
		name = "+workspace",
		["<tab>"] = { "<cmd>tabnew<CR>", "New Tab" },

		n = { "<cmd>tabnext<CR>", "Next" },
		d = { "<cmd>tabclose<CR>", "Close" },
		p = { "<cmd>tabprevious<CR>", "Previous" },
		["]"] = { "<cmd>tabnext<CR>", "Next" },
		["["] = { "<cmd>tabprevious<CR>", "Previous" },
		f = { "<cmd>tabfirst<CR>", "First" },
		l = { "<cmd>tablast<CR>", "Last" },
	},
	["`"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
	["."] = { ":Telescope file_browser<CR>", "Browse Files" },
	[","] = { "<cmd>Telescope buffers show_all_buffers=true<cr>", "Switch Buffer" },
	["/"] = { "<cmd>Telescope live_grep<cr>", "Search" },
	[":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
	q = {
		name = "+quit/session",
		q = { "<cmd>:qa<cr>", "Quit" },
		["!"] = { "<cmd>:qa!<cr>", "Quit without saving" },
	},
	x = {
		name = "+errors",
		x = { "<cmd>TroubleToggle<cr>", "Trouble" },
		w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Trouble" },
		d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Trouble" },
		t = { "<cmd>TodoTrouble<cr>", "Todo Trouble" },
		T = { "<cmd>TodoTelescope<cr>", "Todo Telescope" },
		l = { "<cmd>lopen<cr>", "Open Location List" },
		q = { "<cmd>copen<cr>", "Open Quickfix List" },
	},
	Z = { [[<cmd>lua require("zen-mode").reset()<cr>]], "Zen Mode" },
	z = { [[<cmd>ZenMode<cr>]], "Zen Mode" },
	T = {
		name = "+tests",
	},
	D = {
		function()
			util.docs()
		end,
		"Create Docs from README.md",
	},
}

for i = 0, 10 do
	leader[tostring(i)] = "which_key_ignore"
end

wk.register(leader, { prefix = "<leader>" })
