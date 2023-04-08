-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

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

map("", "<Space>", "<Nop>", opts)

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

-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
map("n", "<A-h>", require("smart-splits").resize_left, { desc = "Resize Left" })
map("n", "<A-j>", require("smart-splits").resize_down, { desc = "Resize Down" })
map("n", "<A-k>", require("smart-splits").resize_up, { desc = "Resize Up" })
map("n", "<A-l>", require("smart-splits").resize_right, { desc = "Resize Right" })

map("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Move Cursor Left" })
map("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Move Cursor Down" })
map("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Move Cursor Up" })
map("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "Move Cursor Right" })

map("n", "<leader><leader>h", require("smart-splits").swap_buf_left, { desc = "Swap Buffer Left" })
map("n", "<leader><leader>j", require("smart-splits").swap_buf_down, { desc = "Swap Buffer Down" })
map("n", "<leader><leader>k", require("smart-splits").swap_buf_up, { desc = "Swap Buffer Up" })
map("n", "<leader><leader>l", require("smart-splits").swap_buf_right, { desc = "Swap Buffer Right" })
