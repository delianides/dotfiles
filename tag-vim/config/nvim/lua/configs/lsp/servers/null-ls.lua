local M = {}

function M.config(options)
  local status_ok, nls = pcall(require, "null-ls")
  if not status_ok then
    return
  end
  nls.setup {
    debug = false,
    debounce = 150,
    save_after_format = false,
    sources = {
      -- nls.builtins.formatting.prettierd,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.fixjson.with { filetypes = { "jsonc" } },

      nls.builtins.diagnostics.actionlint.with {
        condition = function()
          local api = vim.api
          local path = api.nvim_buf_get_name(api.nvim_get_current_buf())
          return path:match "github/workflows/" ~= nil
        end,
      },
      nls.builtins.diagnostics.yamllint,
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.luacheck.with {
        extra_args = { "--globals", "vim" },
      },
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
