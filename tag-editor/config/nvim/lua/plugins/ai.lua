return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = function()
      local opts = {
        terminal = {
          split_side = "left", -- "left" or "right"
          git_repo_cwd = true,
          snacks_win_opts = {
            position = "bottom",
            height = 0.4,
            width = 1.0,
            border = "rounded",
            title = " Claude ",
            title_pos = "center",
          },
        },
      }

      if vim.env.CMUX_WORKSPACE_ID then
        opts.terminal.provider = require("claudecode_providers.cmux").new()
      elseif vim.env.TMUX then
        opts.terminal.provider = require("claudecode_providers.tmux").new({
          size = "40%",
          direction = "down",
        })
      end

      return opts
    end,
  },
}
