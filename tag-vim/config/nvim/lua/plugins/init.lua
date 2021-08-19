vim.cmd [[packadd packer.nvim]]
vim.cmd [[packadd vimball]]

require'packer'.init({
  max_jobs=50
})

require("packer").startup {
  function(use)
    use "wbthomason/packer.nvim"
    use {
      "folke/trouble.nvim",
      config = function()
        -- Can use P to toggle auto movement
        require("trouble").setup {
          auto_preview = false,
          auto_fold = true,
        }
      end,
    }

    use 'ThePrimeagen/harpoon' -- quick file navigation for current workspaces
    use 'christoomey/vim-tmux-navigator'

    -- telescope fuzzy finder
    use { "nvim-telescope/telescope.nvim", requires = {{ 'nvim-lua/popup.nvim' }, {'nvim-lua/plenary.nvim'} }}
    use "nvim-telescope/telescope-fzf-writer.nvim"
    use "nvim-telescope/telescope-packer.nvim"
    use "nvim-telescope/telescope-fzy-native.nvim"
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use "nvim-telescope/telescope-github.nvim"
    use "nvim-telescope/telescope-symbols.nvim"
    use "nvim-telescope/telescope-frecency.nvim"
    use "nvim-telescope/telescope-cheat.nvim"
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup()
      end,
    }
    use {
      "norcalli/nvim-terminal.lua",
      config = function()
        require("terminal").setup()
      end,
    }

    use "tjdevries/vim-inyoface"
    use "kyazdani42/nvim-web-devicons"
    use "yamatsum/nvim-web-nonicons"

    use {
      "kyazdani42/nvim-tree.lua",
      config = function()
        local function setup(opts)
          for opt, value in pairs(opts) do
            if type(value) == 'boolean' then
              value = value and 1 or 0
            end
            vim.g['nvim_tree_' .. opt] = value
          end
        end

        setup {
          auto_open = true,
          tree_side = 'left',
          width_allow_resize = true,
          follow = true,
          highlight_opened_files = true,
          auto_resize = true,
          hide_dotfiles = false,
          indent_markers = true,
          ignore = { '.git', 'node_modules', '.cache', '__pycache__' },
          disable_window_picker = true,
        }
      end
    }
    use "lambdalisue/vim-protocol"
    use "sjl/gundo.vim" -- Undo helper
    use "gyim/vim-boxdraw" -- Crazy good box drawing

    -- markdown
    use "junegunn/goyo.vim"
    use "junegunn/limelight.vim"

    use { "elzr/vim-json", ft = "json" }
    use { "fatih/vim-go", ft = "golang", run = ":GoInstallBinaries" }
    use { "cespare/vim-toml", ft = "toml" }
    use { "iamcco/markdown-preview.nvim", ft = "markdown", run = "cd app && yarn install" }
    use { "rust-lang/rust.vim", ft = "rust" }
    use { 'eraserhd/parinfer-rust', run = 'cargo build --release' }
    use "jelera/vim-javascript-syntax"
    use "othree/javascript-libraries-syntax.vim"
    use "leafgarland/typescript-vim"
    use "peitalin/vim-jsx-typescript"
    use { "numirias/semshi", ft = "python" }
    use { "uiiaoo/java-syntax.vim", ft = "java" }

    use { "vim-scripts/JavaScript-Indent", ft = "javascript" }
    use { "pangloss/vim-javascript", ft = { "javascript", "html" } }

    use "kabouzeid/nvim-lspinstall"
    use "neovim/nvim-lspconfig"
    use "nvim-lua/lsp-status.nvim"
    use "ray-x/lsp_signature.nvim"
    use "nvim-lua/lsp_extensions.nvim"
    use {
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      requires = {{"nvim-lua/plenary.nvim"},{"jose-elias-alvarez/null-ls.nvim"}},
      config = function()
        require("null-ls").config {}
        require("lspconfig")["null-ls"].setup {}
      end,
    }
    use "glepnir/lspsaga.nvim"
    use "onsails/lspkind-nvim"
    use "hrsh7th/nvim-compe"

    -- Completion stuff
    use "tjdevries/rofl.nvim"

    use "hrsh7th/vim-vsnip"
    use "hrsh7th/vim-vsnip-integ"
    use 'norcalli/snippets.nvim'
    -- Find and replace
    use {
      "brooth/far.vim",
      cond = function()
        return vim.fn.has "python3" == 1
      end,
    }
    use 'tjdevries/astronauta.nvim'
    use {
      "rcarriga/vim-ultest",
      requires = { "vim-test/vim-test" },
      run = ":UpdateRemotePlugins",
      cond = function()
        return vim.fn.has "python3" == 1
      end,
      config = function()
        vim.cmd [[nmap ]t <Plug>(ultest-next-fail)]]
        vim.cmd [[nmap [t <Plug>(ultest-prev-fail)]]
      end,
    }

    use {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require'nvim-treesitter.configs'.setup {
          ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
          highlight = {
            enable = true,              -- false will disable the whole extension
          },
        }
      end,
    }

    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "nvim-treesitter/playground"
    use "vigoux/architext.nvim"
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use {
      "mfussenegger/nvim-ts-hint-textobject",
      config = function()
        vim.cmd [[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]]
        vim.cmd [[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]
      end,
    }
    use {
      "romgrk/nvim-treesitter-context",
      config = function()
        require("treesitter-context.config").setup {
          enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        }

        -- TODO: Decide on a better highlighting color
        -- vim.cmd [[highlight TreesitterContext link NormalFloat]]
      end,
    }

    use "godlygeek/tabular" -- Quickly align text by pattern
    use "tpope/vim-commentary" -- Easily comment out lines or objects
    use "tpope/vim-repeat" -- Repeat actions better
    use "tpope/vim-abolish" -- Cool things with words!
    use "tpope/vim-characterize"
    use "tpope/vim-dispatch"
    use "AndrewRadev/splitjoin.vim"
    use "tpope/vim-surround" -- Surround text objects easily

    use "akinsho/nvim-toggleterm.lua" -- TODO
    use {
      "TimUntersberger/neogit",
      requires = { "sindrets/diffview.nvim" },
      config = function()
        require('neogit').setup {
          disable_commit_confirmation = true,
          integrations = {
            diffview = true
          }
        }
      end
    }

    if vim.fn.executable "gh" == 1 then
      use {
        "pwntester/octo.nvim",
        config = function()
          require"octo".setup()
        end,
      }
    end

    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      options = function ()
          require('gitsigns').setup()
      end,
    } -- TODO
    use "rhysd/committia.vim" -- Sweet message committer
    use "rhysd/git-messenger.vim" -- Floating windows are awesome :)
    use {
      "ThePrimeagen/git-worktree.nvim",
      config = function()
        require("git-worktree").setup {}
      end,
    }
    use {
      "tjdevries/colorbuddy.nvim",
    }
    use {
      'projekt0n/github-nvim-theme',
      config = function()
        require('github-theme').setup({
          themeStyle = 'dark'
        })
      end,
    }
    use "sainnhe/sonokai"
    use "morhetz/gruvbox"
    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
  end
}

