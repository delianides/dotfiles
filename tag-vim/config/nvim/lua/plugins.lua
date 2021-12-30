local packer = require "util.packer"
local config = {
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
  max_jobs = 50,
  -- list of plugins that should be taken from ~/projects
  -- this is NOT packer functionality!
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
  local_plugins = {},
}

local function plugins(use)
  use { "wbthomason/packer.nvim", opt = true }

  -- utilities
  use { "nvim-lua/plenary.nvim", module = "plenary" }
  use { "nvim-lua/popup.nvim", module = "popup" }
  use { "lewis6991/impatient.nvim", rocks = "mpack" }
  use { "stevearc/dressing.nvim", event = "BufReadPre" }
  use {
    "nathom/filetype.nvim",
    config = function()
      require("filetype").setup {}
    end,
  }
  use {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  }

  use {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require "notify"
    end,
  }
  use { "mbbill/undotree", cmd = "UndotreeToggle" }

  -- themes
  use "sainnhe/sonokai"
  use "rebelot/kanagawa.nvim"

  use "tjdevries/colorbuddy.vim"
  use "tjdevries/gruvbuddy.nvim"

  -- statusline
  use {
    "hoob3rt/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require "config.lualine"
    end,
  }
  use {
    "SmiteshP/nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter",
    wants = "nvim-treesitter",
    module = "nvim-gps",
    config = function()
      require("nvim-gps").setup { separator = "   " }
    end,
  }

  -- illuminate highlight the same word
  use {
    "RRethy/vim-illuminate",
    event = "CursorHold",
    module = "illuminate",
    config = function()
      vim.g.Illuminate_delay = 1000
    end,
  }

  -- search
  use {
    "windwp/nvim-spectre",
    opt = true,
    module = "spectre",
    wants = { "plenary.nvim", "popup.nvim" },
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  }

  -- icons that are just circles
  use {
    "projekt0n/circles.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("circles").setup { icons = { empty = "", filled = "", lsp_prefix = "" } }
    end,
  }

  -- file browser
  use {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require "config.tree"
    end,
  }

  use {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
  }

  -- quick file navigation for current workspaces
  use {
    "ThePrimeagen/harpoon",
    config = function()
      require "config.harpoon"
    end,
  }

  use "christoomey/vim-tmux-navigator"
  use { "pwntester/octo.nvim" }
  use { "folke/lsp-trouble.nvim", config = "require('config.trouble')" }

  -- telescope fuzzy finder
  use {
    "nvim-telescope/telescope.nvim",
    opt = true,
    config = function()
      require "config.telescope"
    end,
    keys = { "<C-f>", "<leader>fd" },
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
      "nvim-telescope/telescope-github.nvim",
      "nvim-telescope/telescope-packer.nvim",
      "nvim-telescope/telescope-node-modules.nvim",
      -- { nvim-telescope/telescope-frecency.nvim", requires = "tami5/sql.nvim" }
    },
  }

  -- Indent Guides and rainbow brackets
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require "config.blankline"
    end,
  }

  -- Tabs
  use {
    "akinsho/nvim-bufferline.lua",
    event = "BufReadPre",
    wants = "nvim-web-devicons",
    config = function()
      require "config.bufferline"
    end,
  }

  -- Terminal
  use {
    "norcalli/nvim-terminal.lua",
    config = function()
      require("terminal").setup()
    end,
  }

  use {
    "numtostr/FTerm.nvim",
    config = function()
      require "config.fterm"
    end,
  }

  -- languages
  --
  -- markdown
  use "junegunn/goyo.vim"
  use "junegunn/limelight.vim"
  use { "ellisonleao/glow.nvim" }

  -- golang
  use { "fatih/vim-go", ft = "golang", run = ":GoInstallBinaries" }

  -- rust
  use { "rust-lang/rust.vim", ft = "rust" }
  use { "eraserhd/parinfer-rust", run = "cargo build --release" }
  use { "racer-rust/vim-racer" }
  use {
    "simrat39/rust-tools.nvim",
    module = "rust-tools",
  }

  -- swift xcode
  use { "keith/swift.vim" }
  use { "gfontenot/vim-xcode" }

  -- toml
  use { "cespare/vim-toml", ft = "toml", branch = "main" }

  -- js/ts
  use { "othree/yajs.vim", ft = { "javascript", "javascript.jsx", "html" } }
  use { "moll/vim-node", ft = "javascript" }
  use {
    "vuki656/package-info.nvim",
    requires = "MunifTanjim/nui.nvim",
    config = function()
      require("package-info").setup { package_manager = "npm" }
    end,
  }
  -- use({ "elzr/vim-json", ft = "json" })
  use { "heavenshell/vim-jsdoc", ft = { "javascript", "javascript.jsx" } }
  use "othree/javascript-libraries-syntax.vim"
  use { "HerringtonDarkholme/yats.vim", ft = { "typescript", "typescript.tsx" } }
  use "MaxMEllon/vim-jsx-pretty"
  use { "jxnblk/vim-mdx-js" }

  -- html
  use { "othree/html5.vim" }
  use { "posva/vim-vue" }
  use { "leafOfTree/vim-svelte-plugin" }
  use { "skwp/vim-html-escape" }
  use { "kana/vim-textobj-user" }
  use { "whatyouhide/vim-textobj-xmlattr" }
  use { "pedrohdz/vim-yaml-folds" }
  -- CSS
  use { "hail2u/vim-css3-syntax" }
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  }

  -- solidity/er20
  use "tomlion/vim-solidity"

  -- python
  use { "numirias/semshi", ft = "python" }

  use {
    "folke/trouble.nvim",
    event = "BufReadPre",
    wants = "nvim-web-devicons",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("trouble").setup { auto_open = false }
    end,
  }

  use {
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
      require "config.lsp"
    end,
    requires = {
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      "jose-elias-alvarez/null-ls.nvim",
      "folke/lua-dev.nvim",
      "nvim-lua/lsp-status.nvim",
      "williamboman/nvim-lsp-installer",
    },
  }

  use "onsails/lspkind-nvim"
  use "ray-x/lsp_signature.nvim"
  use "nvim-lua/lsp_extensions.nvim"
  use "glepnir/lspsaga.nvim"

  use {
    "hrsh7th/nvim-cmp",
    opt = true,
    event = "InsertEnter",
    config = function()
      require "config.completion"
    end,
    wants = { "LuaSnip" },
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "David-Kunz/cmp-npm",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-look",
      "hrsh7th/cmp-calc",
      "saadparwaiz1/cmp_luasnip",
      "windwp/nvim-autopairs",
      {
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
        config = function()
          require "config.snippets"
        end,
      },
      {
        "windwp/nvim-autopairs",
        config = function()
          require "config.autopairs"
        end,
      },
      "rafamadriz/friendly-snippets",
    },
  }

  use { "tzachar/cmp-tabnine", run = "./install.sh", config = "require('config.tabnine')", after = "cmp-calc" }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    opt = true,
    event = "BufRead",
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      { "nvim-treesitter/playground", cmd = "TSHighlightCapturesUnderCursor" },
      "RRethy/nvim-treesitter-textsubjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      { "windwp/nvim-ts-autotag", config = "require('config.autotag')" },
    },
    config = [[require('config.treesitter')]],
  }

  use {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require "config.keys"
    end,
  }

  use { "numToStr/Comment.nvim", config = "require('config.comments')" }

  use "tpope/vim-repeat"
  use "tpope/vim-characterize"
  use "tpope/vim-dispatch"
  use "AndrewRadev/splitjoin.vim"
  use "tpope/vim-surround"

  -- git
  use {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    wants = "plenary.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require "config.gitsigns"
    end,
  }

  use {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    config = function()
      require "config.neogit"
    end,
  }

  use {
    "ThePrimeagen/git-worktree.nvim",
    config = function()
      require("git-worktree").setup {}
    end,
  }
end

packer.setup(config, plugins)
