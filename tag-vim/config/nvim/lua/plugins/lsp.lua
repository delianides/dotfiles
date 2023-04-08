return {
  {
    "ray-x/lsp_signature.nvim",
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

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- language specific extension modules
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.linting.eslint" },
  -- { import = "plugins.extras.lang.go" },
  -- { import = "plugins.extras.lang.java" },
  -- { import = "plugins.extras.lang.rust" },
  { import = "plugins.extras.lang.nodejs" },
}
