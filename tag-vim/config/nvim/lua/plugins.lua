local packer = require("util.packer")
local config = {
	profile = {
		enable = true,
		threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
	},
	max_jobs = 50,
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
	-- list of plugins that should be taken from ~/projects
	-- this is NOT packer functionality!
	local_plugins = {},
}

local function plugins(use)
	use({ "wbthomason/packer.nvim", opt = true })
	use("mhinz/vim-startify")
	use({
		"sainnhe/sonokai",
	})

	use("tjdevries/colorbuddy.vim")
	use("tjdevries/gruvbuddy.nvim")
	use({
		"hoob3rt/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("config.lualine")
		end,
	})

	use({
		"tjdevries/colorbuddy.nvim",
	})

	use({
		"RRethy/vim-illuminate",
		event = "CursorHold",
		module = "illuminate",
		config = function()
			vim.g.Illuminate_delay = 1000
		end,
	})

	use({
		"windwp/nvim-spectre",
		opt = true,
		module = "spectre",
		wants = { "plenary.nvim", "popup.nvim" },
		requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
	})

	use({
		"projekt0n/circles.nvim",
		requires = {
			{ "kyazdani42/nvim-web-devicons" },
			{
				"kyazdani42/nvim-tree.lua",
				opt = true,
				config = function()
					local function setup(opts)
						for opt, value in pairs(opts) do
							if type(value) == "boolean" then
								value = value and 1 or 0
							end
							vim.g["nvim_tree_" .. opt] = value
						end
					end

					setup({
						auto_open = true,
						tree_side = "left",
						width_allow_resize = true,
						follow = true,
						highlight_opened_files = true,
						auto_resize = true,
						hide_dotfiles = false,
						indent_markers = true,
						ignore = { ".git", "node_modules", ".cache", "__pycache__" },
						disable_window_picker = true,
					})
				end,
			},
		},
		config = function()
			require("circles").setup({ icons = { empty = "", filled = "", lsp_prefix = "" } })
		end,
	})

	use({
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline" },
	})

	use("ThePrimeagen/harpoon") -- quick file navigation for current workspaces
	use("christoomey/vim-tmux-navigator")

	-- telescope fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		opt = true,
		config = function()
			require("config.telescope")
		end,
		keys = { "<Leader><space>", "<leader>fd" },
		cmd = { "Telescope" },
		module = "telescope",
		wants = {
			"plenary.nvim",
			"popup.nvim",
			"telescope-fzy-native.nvim",
			"trouble.nvim",
			"telescope-symbols.nvim",
		},
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
			"nvim-telescope/telescope-cheat.nvim",
			-- { nvim-telescope/telescope-frecency.nvim", requires = "tami5/sql.nvim" }
		},
	})

	-- Indent Guides and rainbow brackets
	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		config = function()
			require("config.blankline")
		end,
	})

	-- Tabs
	use({
		"akinsho/nvim-bufferline.lua",
		event = "BufReadPre",
		wants = "nvim-web-devicons",
		config = function()
			require("config.bufferline")
		end,
	})

	-- Terminal
	use({
		"akinsho/nvim-toggleterm.lua",
		keys = "<M-`>",
		config = function()
			require("config.terminal")
		end,
	})

	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})
	use({
		"norcalli/nvim-terminal.lua",
		config = function()
			require("terminal").setup()
		end,
	})

	use({ "nvim-lua/plenary.nvim", module = "plenary" })
	use({ "nvim-lua/popup.nvim", module = "popup" })

	-- markdown
	use("junegunn/goyo.vim")
	use("junegunn/limelight.vim")

	-- languages
	use({ "fatih/vim-go", ft = "golang", run = ":GoInstallBinaries" })
	use({ "rust-lang/rust.vim", ft = "rust" })
	use({ "cespare/vim-toml", ft = "toml", branch = "main" })

	use({ "eraserhd/parinfer-rust", run = "cargo build --release" })

	use({ "othree/yajs.vim", ft = { "javascript", "javascript.jsx", "html" } })
	use({ "moll/vim-node", ft = "javascript" })
	use("othree/javascript-libraries-syntax.vim")
	use({ "leafgarland/typescript-vim", ft = { "typescript", "typescript.tsx" } })
	use("MaxMEllon/vim-jsx-pretty")
	use("tomlion/vim-solidity")
	use({ "numirias/semshi", ft = "python" })

	use({
		"folke/trouble.nvim",
		event = "BufReadPre",
		wants = "nvim-web-devicons",
		cmd = { "TroubleToggle", "Trouble" },
		config = function()
			require("trouble").setup({ auto_open = false })
		end,
	})

	use({
		"neovim/nvim-lspconfig",
		opt = true,
		event = "BufReadPre",
		wants = {
			"nvim-lsp-ts-utils",
			"null-ls.nvim",
			"lua-dev.nvim",
			"cmp-nvim-lsp",
			"lsp-status.nvim",
			"nvim-lsp-installer",
		},
		config = function()
			require("config.lsp")
		end,
		requires = {
			"jose-elias-alvarez/nvim-lsp-ts-utils",
			"jose-elias-alvarez/null-ls.nvim",
			"folke/lua-dev.nvim",
			"nvim-lua/lsp-status.nvim",
			"williamboman/nvim-lsp-installer",
		},
	})

	use("onsails/lspkind-nvim")
	use("ray-x/lsp_signature.nvim")
	use("nvim-lua/lsp_extensions.nvim")
	use("glepnir/lspsaga.nvim")

	use({
		"hrsh7th/nvim-cmp",
		opt = true,
		event = "InsertEnter",
		config = function()
			require("config.completion")
		end,
		wants = { "LuaSnip" },
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-look",
			"saadparwaiz1/cmp_luasnip",
			{
				"L3MON4D3/LuaSnip",
				wants = "friendly-snippets",
				config = function()
					require("config.snippets")
				end,
			},
			"rafamadriz/friendly-snippets",
			{
				"windwp/nvim-autopairs",
				config = function()
					require("config.autopairs")
				end,
			},
		},
	})

	-- Completion stuff
	-- use "tjdevries/rofl.nvim"

	-- Find and replace
	-- use {
	--   "brooth/far.vim",
	--   cond = function()
	--     return vim.fn.has "python3" == 1
	--   end
	-- }

	-- use "tjdevries/astronauta.nvim"
	use({
		"rcarriga/vim-ultest",
		requires = { "vim-test/vim-test" },
		run = ":UpdateRemotePlugins",
		cond = function()
			return vim.fn.has("python3") == 1
		end,
		config = function()
			vim.cmd([[nmap ]t <Plug>(ultest-next-fail)]])
			vim.cmd([[nmap [t <Plug>(ultest-prev-fail)]])
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		opt = true,
		event = "BufRead",
		requires = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			{ "nvim-treesitter/playground", cmd = "TSHighlightCapturesUnderCursor" },
			"RRethy/nvim-treesitter-textsubjects",
			-- {
			--   "mfussenegger/nvim-ts-hint-textobject",
			--   config = function()
			--     vim.cmd [[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]]
			--     vim.cmd [[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]
			--   end
			-- },
			-- {
			--   "romgrk/nvim-treesitter-context",
			--   config = function()
			--     require("treesitter-context.config").setup {
			--       enable = true -- Enable this plugin (Can be enabled/disabled later via commands)
			--     }

			--     -- TODO: Decide on a better highlighting color
			--     -- vim.cmd [[highlight TreesitterContext link NormalFloat]]
			--   end
			-- }
		},
		config = [[require('config.treesitter')]],
	})

	use({
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
	})

	use({
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			require("config.keys")
		end,
	})

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use("tpope/vim-repeat") -- Repeat actions better
	use("tpope/vim-characterize")
	use("tpope/vim-dispatch")
	use("AndrewRadev/splitjoin.vim")
	use("tpope/vim-surround") -- Surround text objects easily

	use({
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		wants = "plenary.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.gitsigns")
		end,
	})

	use({
		"TimUntersberger/neogit",
		cmd = "Neogit",
		config = function()
			require("config.neogit")
		end,
	})

	use({
		"ThePrimeagen/git-worktree.nvim",
		config = function()
			require("git-worktree").setup({})
		end,
	})

	use({
		"karb94/neoscroll.nvim",
		keys = { "<C-u>", "<C-d>", "gg", "G" },
		config = function()
			require("config.scroll")
		end,
	})

	use({
		"edluffy/specs.nvim",
		after = "neoscroll.nvim",
		config = function()
			require("config.specs")
		end,
	})
end

packer.setup(config, plugins)
