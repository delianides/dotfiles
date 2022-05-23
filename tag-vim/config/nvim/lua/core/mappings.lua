local M = {}

local util = require("core.utils")
local wk = require('which-key')
local opts = { noremap = true, silent = true }

-- Remap space as leader key
util.map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable macros
util.nmap("q", "<Nop>")
util.nmap("Q", "<Nop>")

-- deletes in visual
util.vnoremap("X", '"_d')

-- quick escape
util.inoremap("jj", "<ESC>")

-- Normal --
-- move faster
util.nnoremap("J", "5j")
util.nnoremap("K", "5k")
util.vnoremap("J", "5j")
util.vnoremap("K", "5k")

-- cycle tabs
util.nnoremap("<S-Tab>", ":tabp<CR>")
util.nnoremap("<Tab>", ":tabn<CR>")

-- Resize with arrows
util.nmap("<C-Up>", "<cmd>resize -2<CR>")
util.nmap("<C-Down>", "<cmd>resize +2<CR>")
util.nmap("<C-Left>", "<cmd>vertical resize -2<CR>")
util.nmap("<C-Right>", "<cmd>vertical resize +2<CR>")

-- Navigate buffers
util.nmap("L", "<cmd>bnext<CR>")
util.nmap("H", "<cmd>bprevious<CR>")

-- Move text up and down
util.nnoremap("<A-j>", ":move .+1<CR>==")
util.nnoremap("<A-k>", ":move .-2<CR>==")
util.inoremap("<A-j>", "<Esc>:move .+1<CR>==gi")
util.inoremap("<A-k>", "<Esc>:move .-2<CR>==gi")
util.vmap("<A-j>", "<cmd>m .+1<CR>==")
util.vmap("<A-k>", "<cmd>m .-2<CR>==")
util.vmap("p", '"_dP')
util.xmap("<A-j>", "<cmd>move '>+1<CR>gv-gv")
util.xmap("<A-k>", "<cmd>move '<-2<CR>gv-gv")

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

-- Comment
util.nmap("gcc", "<cmd>lua require('Comment.api').toggle_current_linewise()<cr>")
util.vmap("gcc", "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>")

util.nmap("<C-s>", "<cmd>w!<CR>")
util.nmap("<C-q>", "<cmd>q!<CR>")
util.nmap("<C-t>", "<cmd>ToggleTerm direction=float<cr>")
util.nmap("<C-\\>", "<cmd>ToggleTerm<CR>")
util.nmap("<C-f>", '<cmd>lua require("configs.telescope").project_files()<CR>')

util.nmap("<C-n>", "<cmd>NvimTreeToggle<CR>")
util.nmap("<C-g>", "<cmd>Neogit kind=split<CR>")

util.vmap("<", "<gv")
util.vmap(">", ">gv")

wk.register({
  b = {
    name = "+buffers",
    n = { "<cmd>bnext<CR>", "Next Buffer"},
    p = { "<cmd>bprevious<CR>", "Previous Buffer"},
    f = { "<cmd>Telescope buffers<CR>", "Telescope Buffers"}
  },
  n = {
    name = "+settings",
    o = { function() util.toggle("relativenumber") end, "Toggle Relative Number" },
  },
  p = {
    name = "+packer",
    i = {"<cmd>PackerInstall<CR>", "Packer Install" },
    S = {"<cmd>PackerSync<CR>", "Packer Sync"},
    s = {"<cmd>PackerStatus<CR>", "Packer Status"},
    U = {"<cmd>PackerUpdate<CR>", "Packer Update"},
  },
  h = {
    name = "+harpoon",
    a = { '<cmd>lua require("harpoon.mark").add_file()<CR>', "Add File to Harpoon"},
    e = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', "Edit Harpoon List"},
    n = { '<cmd>lua require("harpoon.ui").nav_next()<CR>', "Goto Next File in Harpoon"},
    p = { '<cmd>lua require("harpoon.ui").nav_prev()<CR>', "Goto Previus File in Harpoon"}
  },
  f = { -- find
    name = "+telescope",
    w = { "<cmd>Telescope live_grep<CR>", "Telescope Live Grep" },
    f = { "<cmd>Telescope find_files<CR>", "Telescope Find Files" },
    b = { "<cmd>Telescope buffers<CR>", "Telescope Buffers" },
    h = { "<cmd>Telescope help_tags<CR>", "Telescope Help Tags" },
    o = { "<cmd>Telescope oldfiles<CR>", "Telescope Old Files" },
    t = { "<cmd>Telescope help_tags<CR>", "Telescope Help Files" },
    p = { "<cmd>Telescope man_pages<CR>", "Telescope Man Pages" },
    r = { "<cmd>Telescope registers<CR>", "Telescope Registers" },
    k = { "<cmd>Telescope keymaps<CR>", "Telescope Keymaps" },
    c = { "<cmd>Telescope commands<CR>", "Telescope Commands" },
    d = { "<cmd>Telescope diagnostics<CR>", "Telescope Diagnostics" }
  },
  w = {
    name = "+git_worktree",
    t = { '<cmd>lua require("telescope").extensions.git_worktree.git_worktrees()<CR>', "Git Worktrees"},
    ["tc"] = { '<cmd>lua require("telescope").extensions.git_worktree.create_git_worktree()<CR>', "Create Git Worktree"},
  }
}, { prefix = "<leader>" })

function _G.set_terminal_keymaps()
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd([[
  augroup TermMappings
    autocmd! TermOpen term://* lua set_terminal_keymaps()
  augroup END
]])

return M
