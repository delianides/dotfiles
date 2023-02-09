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
    cmd = "DiffviewOpen",
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    },
  },
  {
    "aserowy/tmux.nvim",
    config = true,
    lazy = false,
  },
  {
    "ThePrimeagen/harpoon",
    config = true,
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
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require("telescope.actions")
      return {
        defaults = {
          file_ignore_patterns = { ".git/", "node_modules/*" },
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
