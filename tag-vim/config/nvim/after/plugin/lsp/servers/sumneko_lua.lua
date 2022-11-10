local lspconfig = safe_require "lspconfig"
if not lspconfig then
  return
end

local neodev = safe_require "neodev"
if not neodev then
  return
end

neodev.setup()

lspconfig.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "P" },
      },
    },
  },
}
