return {
  {
    "mason.nvim",
    opts = function(_, opts)
      print("hello")
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "cfn-lint" })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        yaml = { "cfn-lint" },
      },
    },
  },
}
