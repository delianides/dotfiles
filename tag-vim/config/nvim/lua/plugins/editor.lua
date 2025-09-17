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
    "christoomey/vim-tmux-navigator",
    event = "BufReadPre",
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
  { "nvim-mini/mini.indentscope", config = true, version = false },
  { "nvim-mini/mini.trailspace", config = true, version = false },
}
