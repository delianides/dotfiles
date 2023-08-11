return {
  { "kevinhwang91/nvim-hlslens", config = true },
  { "utilyre/barbecue.nvim", config = true },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.presets = {
        command_palette = true, -- position the cmdline and popupmenu together
        lsp_doc_border = true, -- add a border to hover docs and signature help
      }
    end,
  },
  {
    "yamatsum/nvim-cursorline",
    opts = { cursorline = { enable = true }, cursorword = { enable = true } },
  },
  {
    "petertriho/nvim-scrollbar",
    opts = { handlers = { diagnostic = true, search = true } },
  },
  { "catppuccin/nvim", branch = "main", name = "catppuccin" },
  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },
}
