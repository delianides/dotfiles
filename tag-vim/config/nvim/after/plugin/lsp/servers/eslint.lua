local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

lspconfig.eslint.setup {
  settings = {
    format = { enable = true },
  },
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = true
  end,
}
