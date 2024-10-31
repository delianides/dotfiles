return {
  {
    "neovim/nvim-lspconfig",
    -- config = function(_, opts)
    --   vim.api.nvim_create_autocmd("LspAttach", {
    --     callback = function(ev)
    --       vim.keymap.del("n", "K", { buffer = ev.buf })
    --     end,
    --   })
    --   if opts.on_attach then
    --     opts.on_attach(args)
    --   end
    -- end,
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          vim.keymap.del("n", "K", { buffer = ev.buf })
        end,
      })
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp", -- Use this branch for the new version
    cmd = "VenvSelect",
    enabled = function()
      return LazyVim.has("telescope.nvim")
    end,
    opts = {
      settings = {
        search = {
          local_share = {
            command = "fd python$ $HOME/.local/share/virtualenvs/",
          },
        },
        options = {
          debug = true,
          notify_user_on_venv_activation = true,
        },
      },
    },
    --  Call config for python files and load the cached venv automatically
    ft = "python",
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "pylint" },
      },
    },
  },
}
