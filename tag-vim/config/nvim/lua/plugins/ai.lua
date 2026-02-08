return {
  {
    "yetone/avante.nvim",
    opts = {
      provider = "claude",
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4-5",
        },
      },
    },
  },
}
