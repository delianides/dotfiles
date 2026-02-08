return {
  {
    "akinsho/git-conflict.nvim",
    event = "BufReadPre",
    config = true,
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
}
