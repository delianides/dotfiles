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
  {
    "Bekaboo/dropbar.nvim",
    enabled = vim.version().minor > 9,
  },
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
    enabled = false,
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
        filtered_items = { never_show = { ".git", ".ds_store" } },
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
      integrations = {
        diffview = true,
      },
      disable_builtin_notifications = true,
    },
    dependencies = { "sindrets/diffview.nvim" },
  },
  { "echasnovski/mini.indentscope", config = true, version = false },
  { "echasnovski/mini.trailspace", config = true, version = false },
}
