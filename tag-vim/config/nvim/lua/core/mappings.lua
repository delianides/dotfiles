local M = {}

local util = require("core.utils")
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
util.nmap("<leader>bn", "<cmd>bnext<CR>")
util.nmap("<leader>bp", "<cmd>bprevious<CR>")
util.nmap("L", "<cmd>bnext<CR>")
util.nmap("H", "<cmd>bprevious<CR>")

-- Move text up and down
util.nnoremap("<A-j>", ":move .+1<CR>==")
util.nnoremap("<A-k>", ":move .-2<CR>==")
util.inoremap("<A-j>", "<Esc>:move .+1<CR>==gi")
util.inoremap("<A-k>", "<Esc>:move .-2<CR>==gi")

util.nnoremap("<leader>no", function()
	util.toggle("relativenumber")
end, { silent = true })

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

-- Packer
util.nmap("<leader>pc", "<cmd>PackerCompile<cr>")
util.nmap("<leader>pI", "<cmd>PackerInstall<cr>")
util.nmap("<leader>pS", "<cmd>PackerSync<cr>")
util.nmap("<leader>ps", "<cmd>PackerStatus<cr>")
util.nmap("<leader>pU", "<cmd>PackerUpdate<cr>")

-- LSP
util.nmap("<leader>lf", "<cmd>lua vim.lsp.buf.formatting_sync()<cr>")
util.nmap("<leader>li", "<cmd>LspInfo<cr>")
util.nmap("<leader>lI", "<cmd>LspInstallInfo<cr>")

-- Harpoon
util.nmap("<leader>pa", '<cmd>lua require("harpoon.mark").add_file()<CR>')
util.nmap("<leader>pe", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>')
util.nmap("<leader>pn", '<cmd>lua require("harpoon.ui").nav_next()<CR>')
util.nmap("<leader>pp", '<cmd>lua require("harpoon.ui").nav_prev()<CR>')

-- Telescope
util.nmap("<leader>fw", "<cmd>Telescope live_grep<CR>")
util.nmap("<leader>gt", "<cmd>Telescope git_status<CR>")
util.nmap("<leader>gb", "<cmd>Telescope git_branches<CR>")
util.nmap("<leader>gc", "<cmd>Telescope git_commits<CR>")
util.nmap("<leader>ff", "<cmd>Telescope find_files<CR>")
util.nmap("<leader>gf", "<cmd>Telescope git_files<CR>")
util.nmap("<leader>fb", "<cmd>Telescope buffers<CR>")
util.nmap("<leader>fh", "<cmd>Telescope help_tags<CR>")
util.nmap("<leader>fo", "<cmd>Telescope oldfiles<CR>")
util.nmap("<leader>sb", "<cmd>Telescope git_branches<CR>")
util.nmap("<leader>ht", "<cmd>Telescope help_tags<CR>")
util.nmap("<leader>mp", "<cmd>Telescope man_pages<CR>")
util.nmap("<leader>fr", "<cmd>Telescope registers<CR>")
util.nmap("<leader>wk", "<cmd>Telescope keymaps<CR>")
util.nmap("<leader>fc", "<cmd>Telescope commands<CR>")
util.nmap("<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>")
util.nmap("<leader>lR", "<cmd>Telescope lsp_references<CR>")
util.nmap("<leader>lD", "<cmd>Telescope diagnostics<CR>")

util.nmap("<C-f>", '<cmd>lua require("configs.telescope").project_files()<CR>')
util.nmap("<leader>wt", "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>")
util.nmap("<leader>ct", "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>")

util.nmap("<leader>sp", "<cmd>lua require('configs.telescope').project()<CR>")
;
-- LSP
util.nmap("go", "<cmd>lua vim.diagnostic.open_float()<CR>")
util.nmap("gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
util.nmap("[d", "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>")
util.nmap("]d", "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>")
util.nmap("gj", "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<cr>")
util.nmap("gk", "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<cr>")
util.nmap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
util.nmap("<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>")
util.nmap("<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>")
util.nmap("<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>")
util.nmap("<leader>tt", "<cmd>Trouble document_diagnostics<CR>")
util.nmap("gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
util.nmap("gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
util.nmap("gP", "<cmd>lua require('goto-preview').close_all_win()<CR>")

-- Comment
util.nmap("gcc", "<cmd>lua require('Comment.api').toggle_current_linewise()<cr>")
util.vmap("gcc", "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>")

-- Git
util.nmap("<leader>gg", "<cmd>Neogit<CR>")

-- ForceWrite
util.nmap("<C-s>", "<cmd>w!<CR>")

-- ForceQuit
util.nmap("<C-q>", "<cmd>q!<CR>")

-- Terminal
util.nmap("<C-\\>", "<cmd>ToggleTerm<CR>")
util.nmap("<leader>tf", "<cmd>ToggleTerm direction=float<cr>")
util.nmap("<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>")
util.nmap("<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>")

-- Visual --
-- Stay in indent mode
util.vmap("<", "<gv")
util.vmap(">", ">gv")

-- Move text up and down
util.vmap("<A-j>", "<cmd>m .+1<CR>==")
util.vmap("<A-k>", "<cmd>m .-2<CR>==")
util.vmap("p", '"_dP')

-- Visual Block --
-- Move text up and down
util.xmap("<A-j>", "<cmd>move '>+1<CR>gv-gv")
util.xmap("<A-k>", "<cmd>move '<-2<CR>gv-gv")

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
