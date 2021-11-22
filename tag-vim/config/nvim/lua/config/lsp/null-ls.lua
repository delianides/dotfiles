local M = {}

function M.setup(options)
  local nls = require "null-ls"
  nls.config {
    debug = false,
    debounce = 150,
    save_after_format = false,
    sources = {
      nls.builtins.formatting.prettierd,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.eslint_d,
      nls.builtins.diagnostics.shellcheck,
      -- nls.builtins.diagnostics.luacheck,
      -- nls.builtins.diagnostics.markdownlint,
      nls.builtins.code_actions.gitsigns,
      -- nls.builtins.diagnostics.selene,
    },
  }
  require("lspconfig")["null-ls"].setup(options)
end

return M
