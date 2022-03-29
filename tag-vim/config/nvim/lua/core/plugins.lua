local packer_status_ok, packer = pcall(require, "packer")
if not packer_status_ok then
  return
end

local config = {
  ensure_dependencies = true,
  profile = {
    enable = true,
    threshold = 0.0001,
  },
  git = {
    clone_timeout = 300,
  },
  auto_clean = true,
  compile_on_sync = true,
  max_jobs = 10,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
  local_plugins = {},
}

local function plugins(use)
  use "wbthomason/packer.nvim"
  use "christoomey/vim-tmux-navigator" -- so tmux and vim get along
  -- ui and lua utilities
  use { "nvim-lua/plenary.nvim", module = "plenary" }
  use { "nvim-lua/popup.nvim", module = "popup" }
  use { "stevearc/dressing.nvim", event = "BufReadPre" }
  use "lewis6991/impatient.nvim" -- cache lua code in nvim to improve startuptime
  use "tjdevries/colorbuddy.vim"
  use "tjdevries/gruvbuddy.nvim"
  use {
    "akinsho/bufferline.nvim",
    config = function()
      require("configs.bufferline").config()
    end,
  }

  -- faster filetype loading
  use {
    "nathom/filetype.nvim",
    config = function()
      require("filetype").setup {}
    end,
  }

  -- metrics for nvim startup
  use {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  }

  -- fix cursorhold_updatetime
  use {
    "antoinemadec/FixCursorHold.nvim",
    event = "BufRead",
    config = function()
      vim.g.cursorhold_updatetime = 100
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

  -- better undo support, after file close
  use { "mbbill/undotree", cmd = "UndotreeToggle" }

  -- themes
  use {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup {
        commentStyle = "italic",
        functionStyle = "NONE",
        keywordStyle = "italic",
        statementStyle = "bold",
        typeStyle = "NONE",
        variablebuiltinStyle = "italic",
        specialReturn = true, -- special highlight for the return keyword
        specialException = true, -- special highlight for exception handling keywords
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        colors = {},
        overrides = {},
      }
    end,
  }

  -- statusline
  use {
    "hoob3rt/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("configs.lualine").config()
    end,
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

  -- quick file navigation for current workspaces
  use {
    "ThePrimeagen/harpoon",
    config = function()
      require("configs.harpoon").config()
    end,
  }

  -- manage github in neovim
  use { "pwntester/octo.nvim" }

  -- telescope fuzzy finder
  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("configs.telescope").config()
    end,
    requires = {
      { "nvim-telescope/telescope-fzy-native.nvim" },
      { "nvim-telescope/telescope-github.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
  }

  -- Indent Guides and rainbow brackets
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require "configs.blankline"
    end,
  }

  -- folds
  use {
    "anuvyklack/pretty-fold.nvim",
    config = function()
      require("pretty-fold").setup {
        keep_indentation = false,
        fill_char = "•",
        sections = {
          left = {
            "+",
            function()
              return string.rep("-", vim.v.foldlevel)
            end,
            " ",
            "number_of_folded_lines",
            ":",
            "content",
          },
        },
      }
      require("pretty-fold.preview").setup()
    end,
  }

  -- Terminal
  use {
    "akinsho/nvim-toggleterm.lua",
    config = function()
      require("configs.toggleterm").config()
    end,
  }
  --
  -- languages
  --
  -- markdown
  use "junegunn/goyo.vim"
  use "junegunn/limelight.vim"
  use "ellisonleao/glow.nvim"

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
  use "keith/swift.vim"
  use "gfontenot/vim-xcode"

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
  use { "heavenshell/vim-jsdoc", ft = { "javascript", "javascript.jsx" } }
  use "othree/javascript-libraries-syntax.vim"
  use { "HerringtonDarkholme/yats.vim", ft = { "typescript", "typescript.tsx" } }
  use "MaxMEllon/vim-jsx-pretty"
  use "jxnblk/vim-mdx-js"
  use "othree/html5.vim"
  use "posva/vim-vue"
  use "leafOfTree/vim-svelte-plugin"
  use "skwp/vim-html-escape"
  use "kana/vim-textobj-user"
  use "whatyouhide/vim-textobj-xmlattr"
  use "pedrohdz/vim-yaml-folds"
  use "hail2u/vim-css3-syntax"
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("configs.colorizer").config()
    end,
  }
  use "b0o/SchemaStore.nvim" -- extra json schema
  use "tomlion/vim-solidity" -- ethereum block chain development

  --
  --
  -- lsp
  --
  --
  -- helpful lsp tools
  use {
    "folke/trouble.nvim",
    event = "BufReadPre",
    wants = "nvim-web-devicons",
    cmd = { "TroubleToggle", "Trouble" },
    config = "require('configs.trouble')",
  }

  -- lsp settings
  use {
    "neovim/nvim-lspconfig",
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
      require "configs.lsp"
    end,
    requires = {
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      "jose-elias-alvarez/null-ls.nvim",
      "folke/lua-dev.nvim",
      "nvim-lua/lsp-status.nvim",
      "williamboman/nvim-lsp-installer",
    },
  }

  use "ray-x/lsp_signature.nvim"
  use "nvim-lua/lsp_extensions.nvim"

  -- Snippet collection
  use {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
  }

  -- Snippet engine
  use {
    "L3MON4D3/LuaSnip",
    after = "friendly-snippets",
    config = function()
      require("configs.luasnip").config()
    end,
  }

  -- Completion engine
  use {
    "hrsh7th/nvim-cmp",
    event = "BufRead",
    config = function()
      require("configs.cmp").config()
    end,
  }

  -- Snippet completion source
  use {
    "saadparwaiz1/cmp_luasnip",
    after = "nvim-cmp",
    config = function()
      require("core.utils").add_cmp_source "luasnip"
    end,
  }

  -- Buffer completion source
  use {
    "hrsh7th/cmp-buffer",
    after = "nvim-cmp",
    config = function()
      require("core.utils").add_cmp_source "buffer"
    end,
  }

  -- Path completion source
  use {
    "hrsh7th/cmp-path",
    after = "nvim-cmp",
    config = function()
      require("core.utils").add_cmp_source "path"
    end,
  }

  -- LSP completion source
  use {
    "hrsh7th/cmp-nvim-lsp",
    after = "nvim-cmp",
    config = function()
      require("core.utils").add_cmp_source "nvim_lsp"
    end,
  }

  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufRead",
    cmd = {
      "TSInstall",
      "TSInstallInfo",
      "TSInstallSync",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
      "TSDisableAll",
      "TSEnableAll",
    },
    config = "require('configs.treesitter')",
  }

  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  }
  use { "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" }
  use { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" }
  use {
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
  }
  use {
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
  }

  -- pair completion
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("configs.autopairs").config()
    end,
  }

  use {
    "numToStr/Comment.nvim",
    config = function()
      require("configs.comments").config()
    end,
  }

  use "tpope/vim-repeat"
  use "tpope/vim-characterize"
  use "tpope/vim-dispatch"
  use "AndrewRadev/splitjoin.vim"
  use "tpope/vim-surround"

  -- git
  use {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("configs.gitsigns").config()
    end,
  }
end

packer.startup {
  function(use)
    plugins(use)
  end,
  config = config,
}
