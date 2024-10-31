-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.swapfile = false
opt.formatoptions = "jcroqlnt"
opt.textwidth = 80

vim.g.maplocalleader = " "
vim.g.mapleader = " "

vim.g.python_host_prog = "/Users/adelianides/.asdf/shims/python"
vim.g.python3_host_prog = "/Users/adelianides/.asdf/shims/python"

-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "pylsp"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"
