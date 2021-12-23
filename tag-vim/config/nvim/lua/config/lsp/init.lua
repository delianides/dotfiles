local lsp_installer = require "nvim-lsp-installer"

require "config.lsp.diagnostics"

local function on_attach(client, bufnr)
  require("config.lsp.formatting").setup(client, bufnr)
  require("config.lsp.keys").setup(client, bufnr)
  require("config.lsp.highlighting").setup(client)

  -- TypeScript specific stuff
  if client.name == "typescript" or client.name == "tsserver" then
    require("config.lsp.ts-utils").setup(client)
  end
end

local servers = {
  pyright = {},
  bashls = {},
  dockerls = {},
  tsserver = {},
  cssls = {},
  jsonls = require("config.lsp.json").config,
  html = {},
  efm = require("config.lsp.efm").config,
  clangd = {},
  sumneko_lua = {},
  vimls = {},
  eslint = {},
  ansiblels = {},
  tailwindcss = {},
}

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lua-dev").setup()

local options = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

require("config.lsp.null-ls").setup(options)
require("config.lsp.install").setup(servers, options)

vim.api.nvim_command "command! LspCapabilities lua require'config.lsp.capabilities'()"
