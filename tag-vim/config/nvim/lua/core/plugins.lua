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
  use {
    "stevearc/dressing.nvim",
    event = "BufReadPre",
    config = function()
      require("configs.dressing").config()
    end,
  }
  use "lewis6991/impatient.nvim" -- cache lua code in nvim to improve startuptime

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

  -- file explorer
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        auto_reload_on_write = true,
        disable_netrw = true,
        hijack_unnamed_buffer_when_opening = true,
        reload_on_bufenter = true,
      }
    end,
    tag = "nightly",
  }
  -- metrics for nvim startup
  use {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
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

  -- notify
  use {
    "rcarriga/nvim-notify",
    event = "VimEnter",
    config = function()
      require("configs.notify").config()
    end,
  }

  -- themes
  use {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup {
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = {bold = true},
        typeStyle = {},
        variablebuiltinStyle = { italic = true },
        specialReturn = true, -- special highlight for the return keyword
        specialException = true, -- special highlight for exception handling keywords
        transparent = false, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        colors = {},
        overrides = {
          WinSeparator = { fg = "#363646" },
          Comment = { fg = "#888181" },
          FloatTitle = { fg = "#14141A", bg = "#957FB8", bold = true },
          DressingInputNormalFloat = { bg = "#14141A" },
          DressingInputFloatBorder = { fg = "#14141A", bg = "#14141A" },
          NeoTreeGitUntracked = { link = "NeoTreeGitModified" },
          IndentBlanklineChar = { fg = "#2F2F40" },
          IndentBlanklineContextStart = { bold = true },
          LualineGitAdd = { link = "GitSignsAdd" },
          LualineGitChange = { link = "GitSignsAdd" },
          LualineGitDelete = { link = "GitSignsDelete" },
          NeoTreeNormal = { bg = "#14141A" },
          NeoTreeNormalNC = { bg = "#14141A" },
          TabLine = {  italic = true , bg = "#363646" },
          TabLineFill = { bg = "#1F1F28" },
          TabLineSel = {  bold = true , bg = "#1F1F28" },
          TabNum = { link = "TabLine" },
          TabNumSel = { link = "TabLineSel" },
          TelescopeBorder = { fg = "#1a1a22", bg = "#1a1a22" },
          TelescopeMatching = {  underline = true , fg = "#7FB4CA", guisp = "#7FB4CA" },
          TelescopeNormal = { bg = "#1a1a22" },
          TelescopePreviewTitle = { fg = "#1a1a22", bg = "#7FB4CA" },
          TelescopePromptBorder = { fg = "#2A2A37", bg = "#2A2A37" },
          TelescopePromptNormal = { fg = "#DCD7BA", bg = "#2A2A37" },
          TelescopePromptPrefix = { fg = "#957FB8", bg = "#2A2A37" },
          TelescopePromptTitle = { fg = "#1a1a22", bg = "#957FB8" },
          TelescopeResultsTitle = { fg = "#1a1a22", bg = "#1a1a22" },
          TelescopeTitle = {  bold = true , fg = "#C8C093" },
          Visual = { bg = "#4C566A" },
        },
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

  -- turns color hex and rgb into highlights
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("configs.colorizer").config()
    end,
  }

  -- quick file navigation for current workspaces
  use {
    "ThePrimeagen/harpoon",
    config = function()
      require("configs.harpoon").config()
    end,
  }

  -- telescope fuzzy finder
  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("configs.telescope").config()
    end,
    requires = {
      { "nvim-telescope/telescope-project.nvim" },
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

  use {
    "editorconfig/editorconfig-vim",
    setup = function()
      vim.g.EditorConfig_max_line_indicator = ""
      vim.g.EditorConfig_preserve_formatoptions = 1
    end,
  }

  --
  -- languages
  --
  -- markdown
  use "ellisonleao/glow.nvim"

  -- golang
  use { "fatih/vim-go", ft = "golang", run = ":GoInstallBinaries" }

  -- rust
  use { "rust-lang/rust.vim", ft = "rust" }

  -- js/ts
  use { "othree/yajs.vim", ft = { "javascript", "javascript.jsx", "html" } }
  use { "moll/vim-node", ft = "javascript" }
  use {
    "heavenshell/vim-jsdoc",
    cmd = "JsDoc",
    ft = { "javascript", "javascript.jsx", "typescript", "typescript.tsx" },
  }
  use "othree/javascript-libraries-syntax.vim"
  use { "HerringtonDarkholme/yats.vim", ft = { "typescript", "typescript.tsx" } }
  use "MaxMEllon/vim-jsx-pretty"
  use "jxnblk/vim-mdx-js"

  -- json
  use "b0o/SchemaStore.nvim" -- extra json schema

  -- web3
  use "tomlion/vim-solidity" -- ethereum block chain development

  -- other
  use "kana/vim-textobj-user"
  use "whatyouhide/vim-textobj-xmlattr"

  -- Git
  use {
    "TimUntersberger/neogit",
    requires = {
      "sindrets/diffview.nvim",
    },
  }

  use {
    "ThePrimeagen/git-worktree.nvim",
    after = "telescope.nvim",
    config = function()
      require("git-worktree").setup()
    end,
  }

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
      "null-ls.nvim",
      "lua-dev.nvim",
      "cmp-nvim-lsp",
      "lsp-status.nvim",
      "nvim-lsp-installer",
    },
    requires = {
      "simrat39/rust-tools.nvim",
      "jose-elias-alvarez/typescript.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "folke/lua-dev.nvim",
      "nvim-lua/lsp-status.nvim",
      "williamboman/nvim-lsp-installer",
    },
  }

  use {
    "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup {
        default_mappings = true,
        opacity = 7,
        post_open_hook = function(buf_handle, win_handle)
          vim.cmd(([[ autocmd WinLeave <buffer> ++once call nvim_win_close(%d, v:false)]]):format(win_handle))
          vim.api.nvim_buf_set_keymap(
            buf_handle,
            "n",
            "<Esc>",
            ("<cmd>call nvim_win_close(%d, v:false)<CR>"):format(win_handle),
            { noremap = true }
          )
        end,
      }
    end,
  }

  use "ray-x/lsp_signature.nvim"
  use "nvim-lua/lsp_extensions.nvim"

  -- tests
  use {
    "janko/vim-test",
    setup = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#term_position"] = "vsplit"
    end,
  }

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

  use {
    "hrsh7th/cmp-cmdline",
    after = "nvim-cmp",
    config = function()
      require("core.utils").add_cmp_source "cmdline"
    end
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

  use {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    after = "nvim-cmp",
    config = function()
      require("core.utils").add_cmp_source "nvim_lsp_signature_help"
    end
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
    "andymass/vim-matchup",
    config = function()
      vim.g.matchup_matchparen_offscreen = {
        method = "popup",
        fullwidth = 1,
        highlight = "OffscreenMatchPopup",
      }
    end,
  }

  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  }
  use { "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" }
  use {
    "JoosepAlviste/nvim-ts-context-commentstring",
    after = "nvim-treesitter",
  }
  use {
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
  }
  use {
    "windwp/nvim-ts-autotag",
    config = function()
      require("configs.autotag").config()
    end,
    after = "nvim-treesitter",
  }

  -- pair completion
  use {
    "windwp/nvim-autopairs",
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

  use {
    "folke/which-key.nvim",
    config = function()
      require("configs.which-key").config()
    end,
  }

  -- git
  use {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("configs.gitsigns").config()
    end,
  }

  -- terminal
  use { "akinsho/nvim-toggleterm.lua",
    cmd = "ToggleTerm",
    module = { "toggleterm", "toggleterm.terminal" },
    config = function()
      require("configs.toggleterm").config()
    end,
  }
end

packer.startup {
  function(use)
    plugins(use)
  end,
  config = config,
}
