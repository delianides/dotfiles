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

-- Remote-plugin host providers are unused on this LazyVim setup; disable them
-- to skip the missing-provider checkhealth warnings.
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- LSP Server to use for Python.
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"

vim.g.lazyvim_mini_snippets_in_completion = true
