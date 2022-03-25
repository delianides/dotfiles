vim.cmd([[colorscheme kanagawa]])

vim.g.mapleader = " "
vim.g.snippets = "luasnip"
-- vim.g.sonokai_diagnostic_virtual_text = "colored"
-- vim.g.sonokai_diagnostic_text_highlight = true
-- vim.g.sonokai_diagnostic_line_highlight = true

vim.wo.signcolumn = "yes"
vim.opt.termguicolors = true -- True color support

vim.opt.undofile = true
vim.opt.undodir = "~/.undodir"
vim.opt.undodir = vim.fn.stdpath("config") .. "/.undodir"
vim.opt.wildignore = "__pycache__"
vim.opt.wildignore = vim.opt.wildignore + { "*.o", "*~", "*.pyc", "*pycache*" }
vim.opt.wildmode = { "longest", "list", "full" }

-- Cool floating window popup menu for completion on command line
vim.opt.pumblend = 17

vim.opt.wildmode = vim.opt.wildmode - "list"
vim.opt.wildmode = vim.opt.wildmode + { "longest", "full" }

vim.opt.wildoptions = "pum"

vim.opt.exrc = true
vim.opt.showmode = false
vim.opt.guicursor = ""
vim.opt.cmdheight = 1 -- Height of the command bar
vim.opt.incsearch = true -- Makes search act like search in modern browsers
vim.opt.showmatch = true -- show matching brackets when text indicator is over them
vim.opt.relativenumber = true -- Show line numbers
vim.opt.number = true -- But show the actual number for the line we're on
vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ... unless there is a capital letter in the query
vim.opt.hidden = true -- I like having buffers stay around
vim.opt.cursorline = true -- Highlight the current line
vim.opt.equalalways = false -- I don't like my windows changing all the time
vim.opt.splitright = true -- Prefer windows splitting to the right
vim.opt.splitbelow = true -- Prefer windows splitting to the bottom
vim.opt.updatetime = 50 -- Make updates happen faster
vim.opt.hlsearch = false -- I wouldn't use this without my DoNoHL function
vim.opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor

-- Tabs
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.wrap = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.breakindent = true
vim.opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
vim.opt.linebreak = true

vim.opt.foldenable = true
vim.opt.modelines = 1

vim.opt.errorbells = false
vim.opt.belloff = "all" -- Just turn the dang bell off

vim.opt.clipboard = "unnamedplus"

vim.opt.inccommand = "split"
vim.opt.swapfile = false -- Living on the edge
vim.opt.shada = { "!", "'1000", "<50", "s10", "h" }

vim.opt.mouse = "a"
vim.opt.termguicolors = true

-- Helpful related items:
--   1. :center, :left, :right
--   2. gw{motion} - Put cursor back after formatting motion.
--
-- TODO: w, {v, b, l}
vim.opt.formatoptions = vim.opt.formatoptions
	- "a" -- Auto formatting is BAD.
	- "t" -- Don't auto format my code. I got linters for that.
	+ "c" -- In general, I like it when comments respect textwidth
	+ "q" -- Allow formatting comments w/ gq
	- "o" -- O and o, don't continue comments
	+ "r" -- But do continue when pressing enter.
	+ "n" -- Indent past the formatlistpat, not underneath it.
	+ "j" -- Auto-remove comments if possible.
	- "2" -- I'm not in gradeschool anymore

-- set joinspaces
vim.opt.joinspaces = false -- Two spaces and grade school, we're done

-- set fillchars=eob:~
vim.opt.fillchars = { eob = "~" }

vim.api.nvim_exec(
	[[
  augroup Terminal
    autocmd!
    au TermOpen * set nonu
  augroup end
]],
	false
)
