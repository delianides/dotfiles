local M = {}

function M.setup(options)
  local nls = require "null-ls"
  nls.setup {
    debug = false,
    debounce = 150,
    save_after_format = false,
    sources = {
      -- nls.builtins.formatting.prettierd,
      nls.builtins.formatting.stylua,
      -- nls.builtins.formatting.eslint_d,
      nls.builtins.formatting.fixjson.with { filetypes = { "jsonc" } },
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.luacheck,
      nls.builtins.diagnostics.markdownlint,
      nls.builtins.code_actions.gitsigns,
      -- nls.builtins.diagnostics.selene,
    },
    on_attach = options.on_attach,
  }
end

function M.has_formatter(ft)
  local sources = require "null-ls.sources"
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

return M
