-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- quick escape
map("i", "jj", "<ESC>", opts)

-- tmux
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "J", "5j", opts)
map("n", "K", "5k", opts)
map("v", "J", "5j", opts)
map("v", "K", "5k", opts)

map("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)

map("i", "<Down>", "<NOP>", opts)
map("i", "<Up>", "<NOP>", opts)
map("i", "<Left>", "<NOP>", opts)
map("i", "<Right>", "<NOP>", opts)
map("n", "<Left>", ':echoe "Use h"<CR>', opts)
map("n", "<Right>", ':echoe "Use l"<CR>', opts)
map("n", "<Up>", ':echoe "Use k"<CR>', opts)
map("n", "<Down>", ':echoe "Use j"<CR>', opts)
