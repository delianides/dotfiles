return {
  {
    "ray-x/lsp_signature.nvim",
    enabled = false,
    opts = {
      bind = true,
      handler_opts = {
        border = "rounded",
      },
      toggle_key = "<M-x>",
    },
  },
  {
    "neovim/nvim-lspconfig",
    version = false,
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "K", false }
      -- add a keymap
      keys[#keys + 1] = { "O", vim.lsp.buf.hover, desc = "Hover" }
    end,
    opts = {
      diagnostics = {
        float = {
          focusable = false,
          style = "minmal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      },
    },
  },
}
