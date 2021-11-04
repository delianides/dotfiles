local wk = require("which-key")
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

-- undo
util.nnoremap("<leader>u", "<cmd>UndotreeToggle<CR>")

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

-- Remap escape to leave terminal mode
-- util.tnoremap( '<Esc>', [[<c-\><c-n>]] )
