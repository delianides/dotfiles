-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.swapfile = false
opt.formatoptions = "jcroqlnt"
opt.textwidth = 80
opt.expandtab = true

vim.g.maplocalleader = " "
vim.g.mapleader = " "

vim.g.python_host_prog = "/Users/adelianides/.asdf/shims/python"
vim.g.python3_host_prog = "/Users/adelianides/.asdf/shims/python"

-- LSP Server to use for Python.
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"

vim.g.lazyvim_mini_snippets_in_completion = true
