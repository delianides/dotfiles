require("configs.lsp.diagnostics").config()
require("configs.lsp.signature").config()

local function on_attach(client, bufnr)
	require("configs.lsp.formatting").config(client, bufnr)
	require("configs.lsp.highlighting").config(client)

	-- TypeScript specific stuff
	if client.name == "typescript" or client.name == "tsserver" then
		require("configs.lsp.servers.typescript").config(client)
	end
end

local servers = {
	pyright = {},
	bashls = {},
	dockerls = {},
	tsserver = {},
	cssls = {},
	jsonls = require("configs.lsp.servers.json").config,
	html = {},
	clangd = {},
	sumneko_lua = {
		settings = {
			Lua = {
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
			},
		},
	},
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

require("configs.lsp.servers.null-ls").config(options)
require("configs.lsp.install").setup(servers, options)

vim.api.nvim_command("command! LspCapabilities lua require'configs.lsp.capabilities'()")
