local Util = require("lazyvim.util")

return {
  -- git conflict
  {
    "akinsho/git-conflict.nvim",
    event = "BufReadPre",
    config = true,
  },
  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = "DiffviewOpen",
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    },
  },
  { "Bekaboo/dropbar.nvim" },
  {
    "mrjones2014/smart-splits.nvim",
    config = true,
    keys = {
      {
        "<A-h>",
        function()
          require("smart-splits").resize_left()
        end,
        desc = "Resize Left",
      },
      {
        "<A-j>",
        function()
          require("smart-splits").resize_down()
        end,
        desc = "Resize Down",
      },
      {
        "<A-k>",
        function()
          require("smart-splits").resize_up()
        end,
        desc = "Resize Up",
      },
      {
        "<A-l>",
        function()
          require("smart-splits").resize_right()
        end,
        desc = "Resize Right",
      },
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Move Cursor Left",
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "Move Cursor Down",
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "Move Cursor Up",
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "Move Cursor Right",
      },
      {
        "<leader><leader>h",
        function()
          require("smart-splits").swap_buf_left()
        end,
        desc = "Swap Buffer Left",
      },
      {
        "<leader><leader>j",
        function()
          require("smart-splits").swap_buf_down()
        end,
        desc = "Swap Buffer Down",
      },
      {
        "<leader><leader>k",
        function()
          require("smart-splits").swap_buf_up()
        end,
        desc = "Swap Buffer Up",
      },
      {
        "<leader><leader>l",
        function()
          require("smart-splits").swap_buf_right()
        end,
        desc = "Swap Buffer Right",
      },
    },
  },
  {
    "abecodes/tabout.nvim",
    config = true,
  },
  {
    "max397574/better-escape.nvim",
    config = true,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    cmd = "HighlightColorsToggle",
    opts = { enable_tailwind = true, enable_named_colors = true },
    enable = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      hide_root_node = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      window = { mappings = { ["l"] = "open", ["o"] = "open" } },
      filesystem = {
        filtered_items = { never_show = { ".git", ".DS_Store" } },
        follow_current_file = true,
        use_libuv_file_watcher = true,
      },
      source_selector = { winbar = true },
    },
  },
  {
    "TimUntersberger/neogit",
    keys = { { "<C-g>", "<cmd>Neogit kind=split<cr>", desc = "NeoGit" } },
    opts = {
      disable_signs = true,
      kind = "split",
      commit_popup = { kind = "split" },
      integrations = { diffview = true },
      disable_builtin_notifications = true,
    },
    dependencies = { "sindrets/diffview.nvim" },
  },
  { "echasnovski/mini.indentscope", version = false },
  { "echasnovski/mini.splitjoin", version = false },
  { "echasnovski/mini.trailspace", version = false },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    opts = function(_, opts)
      local actions = require("telescope.actions")
      return {
        defaults = {
          preview = {
            treesitter = false,
          },
          file_ignore_patterns = { ".git/", "node_modules/*", "__snapshots__" },
          mappings = {
            -- pull the mappings from lazyvim
            i = vim.list_extend(opts.defaults.mappings.i, {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
            }),
            n = {
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
            },
          },
        },
        pickers = {
          find_files = { theme = "dropdown", previewer = false },
          buffers = { theme = "dropdown", previewer = false },
        },
      }
    end,
  },
}
