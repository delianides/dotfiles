local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local servers = require("nvim-lsp-installer.servers")
local server = require("nvim-lsp-installer.server")
local path = require("nvim-lsp-installer.path")
local npm = require("nvim-lsp-installer.installers.npm")
local server_name = "emmet-language-server"

configs[server_name] = {
	default_config = {
		filetypes = {
			"html",
			"typescriptreact",
			"javascriptreact",
			"javascript",
			"typescript",
			"javascript.jsx",
			"typescript.tsx",
			"css",
		},
		root_dir = lspconfig.util.root_pattern(".git"),
	},
}

local root_dir = server.get_server_root_path(server_name)

local my_server = server.Server:new({
	name = server_name,
	root_dir = root_dir,
	installer = npm.packages({ "@kozer/emmet-language-server " }),
	default_options = {
		cmd = { path.concat({ root_dir, "node_modules", ".bin", "emmet-language-server" }), "--stdio" },
	},
})

servers.register(my_server)
