local inoremap = vim.keymap.inoremap
local nnoremap = vim.keymap.nnoremap
local vnoremap = vim.keymap.vnoremap
local tnoremap = vim.keymap.tnoremap
local vmap = vim.keymap.vmap
local nmap = vim.keymap.nmap

-- disable macros
nmap { 'q', '<Nop>' }

-- deletes in visual
vnoremap { 'X', '"_d' }

-- undo
nnoremap { '<leader>u', '<cmd>UndotreeToggle<CR>' }

-- quick escape
inoremap { 'jj', '<ESC>' }

-- move faster
nnoremap { 'H', '^' }
nnoremap { 'L', 'g_' }
nnoremap { 'J', '5j' }
nnoremap { 'K', '5k' }
vnoremap { 'J', '5j' }
vnoremap { 'K', '5k' }
-- vnoremap { 'K', '<cmd>m "<-2<CR>gv=gv"' }
-- vnoremap { 'J', '<cmd>m ">+1<CR>gv=gv"' }

-- cycle tabs
nnoremap { '<S-Tab>', ':tabp<CR>' }
nnoremap { '<Tab>', ':tabn<CR>' }

-- indent
vmap { '<','<gv' }
vmap { '>','>gv' }

-- disable arrow keys
inoremap { '<Down>', '<NOP>' }
inoremap { '<Up>', '<NOP>' }
inoremap { '<Left>', '<NOP>' }
inoremap { '<Right>', '<NOP>' }
nnoremap { '<Left>', ':echoe "Use h"<CR>'}
nnoremap { '<Right>', ':echoe "Use l"<CR>'}
nnoremap { '<Up>', ':echoe "Use k"<CR>'}
nnoremap { '<Down>', ':echoe "Use j"<CR>'}

-- Add move line shortcuts
nnoremap { '<A-j>', ":m .+1<CR>==" }
nnoremap { '<A-k>', ":m .-2<CR>==" }
inoremap { '<A-j>', '<Esc>:m .+1<CR>==gi' }
inoremap { '<A-k>', '<Esc>:m .-2<CR>==gi' }
vnoremap { '<A-j>', ":m '>+1<CR>gv=gv" }
vnoremap { '<A-k>', ":m '<-2<CR>gv=gv" }

-- Remap escape to leave terminal mode
tnoremap { '<Esc>', [[<c-\><c-n>]] }
