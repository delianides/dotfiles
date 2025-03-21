return {
  { "catppuccin/nvim", branch = "main", name = "catppuccin" },
  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
      },
    },
  },
}
