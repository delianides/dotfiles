return {
  {
    url = "https://github.com/stefanboca/venv-selector.nvim",
    branch = "sb/push-rlpxsqmllxtz", -- Use this branch for the new version
    enabled = true,
    cmd = "VenvSelect",
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
}
