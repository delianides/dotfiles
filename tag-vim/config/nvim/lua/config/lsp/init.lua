require("config.lsp.diagnostics")

local function on_attach(client, bufnr)
	require("config.lsp.formatting").setup(client, bufnr)
	require("config.lsp.keys").setup(client, bufnr)
	-- require("config.lsp.completion").setup(client, bufnr)
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
	jsonls = {},
	html = {},
	clangd = {},
	sumneko_lua = {},
	efm = require("config.lsp.efm").config,
	vimls = {},
	-- eslint = {},
	ansiblels = {},
	tailwindcss = {},
}

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

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

-- local status = require "config.lsp.status"
-- local nvim_status = require "lsp-status"
-- local lspconfig = require "lspconfig"
-- local handlers = require "config.lsp.handlers"
-- local util = require "util"
-- local configs = require "lspconfig/configs"
--
-- local inoremap = util.inoremap
-- local nnoremap = util.nnoremap
-- local vnoremap = util.vnoremap
--
-- local filetype_attach =
--   setmetatable(
--   {
--     go = function()
--       vim.cmd [[
--       augroup lsp_buf_format
--         au! BufWritePre <buffer>
--         autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
--       augroup END
--     ]]
--     end,
--     rust = function()
--       telescope_mapper(
--         "<space>wf",
--         "lsp_workspace_symbols",
--         {
--           ignore_filename = true,
--           query = "#"
--         },
--         true
--       )
--
--       vim.cmd [[
--       autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request {aligned = true, prefix = " » "}
--     ]]
--
--       vim.cmd [[
--       augroup lsp_buf_format
--         au! BufWritePre <buffer>
--         autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting(nil, 5000)
--       augroup END
--     ]]
--     end
--   },
--   {
--     __index = function()
--       return function()
--       end
--     end
--   }
-- )
--
-- status.activate()
--
-- local nvim_exec = function(txt)
--   vim.api.nvim_exec(txt, false)
-- end
--
-- local on_attach = function(client, bufnr)
--   local filetype = vim.api.nvim_buf_get_option(0, "filetype")
--   nvim_status.on_attach(client)
--
--   -- Mappings.
--   util.nnoremap ( "[e", '<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()<CR>', { buffer = bufnr} )
--   util.nnoremap ( "]e", '<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_next()<CR>', { buffer = bufnr} )
--   util.nnoremap ( "<Leader>sl", '<cmd>lua require"lspsaga.diagnostic".show_line_diagnostics()<CR>', {buffer = bufnr} )
--   util.nnoremap ( "<Leader>sc", '<cmd>lua require"lspsaga.diagnostic".show_cursor_diagnostics()<CR>', {buffer = bufnr} )
--
--   util.nnoremap ( "<Leader>cr", '<cmd>lua require("lspsaga.rename").rename()<CR>', {buffer = bufnr})
--
--   util.nnoremap ( "<space>gI", handlers.implementation, { buffer = bufnr} )
--   util.inoremap ( "gs", '<cmd>lua require"lspsaga.signaturehelp".signature_help()<CR>', { buffer = bufnr} )
--   util.nnoremap ( "gd", vim.lsp.buf.definition )
--   util.nnoremap ( "pd", '<cmd>lua require"lspsaga.provider".preview_definition()<CR>', { buffer = bufnr} )
--   util.nnoremap ( "gh", '<cmd>lua require"lspsaga.provider".lsp_finder<CR>', { buffer = bufnr} )
--   util.nnoremap ( "gD", vim.lsp.buf.declaration, { buffer = bufnr} )
--   util.nnoremap ( "gT", vim.lsp.buf.type_definition, { buffer = bufnr} )
--
--   util.nnoremap ( "<Leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr} )
--   util.nnoremap ( "<Leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr} )
--   util.nnoremap ( "<Leader>rn", vim.lsp.buf.rename, { buffer = bufnr} )
--   util.nnoremap ( "<Leader>P", vim.lsp.buf.formatting, { buffer = bufnr} )
--   util.vnoremap ( "<Leader>p", vim.lsp.buf.range_formatting, { buffer = bufnr} )
--   util.nnoremap ( "<Leader>l", vim.lsp.codelens.run, { buffer = bufnr} )
--
--   -- vim already has builtin docs
--   if vim.bo.ft ~= "vim" then
--     util.nnoremap ( "H", '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', { buffer = bufnr} )
--   end
--
--   -- wont keep these arrows as the map but just testing for now
--   util.nnoremap ( "<C-b>", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>' )
--   util.nnoremap ( "<C-f>", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>' )
--
--   vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
--
--   -- Set autocommands conditional on server_capabilities
--   if client.resolved_capabilities.document_highlight then
--     nvim_exec [[
--       augroup lsp_document_highlight
--         autocmd! * <buffer>
--         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--       augroup END
--     ]]
--   end
--
--   if client.resolved_capabilities.code_lens then
--     vim.cmd [[
--     augroup lsp_codelens
--       autocmd! * <buffer>
--       autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
--     augroup END
--     ]]
--   end
--
--   filetype_attach[filetype](client)
-- end
--
-- -- Configure lua language server for neovim development
-- local lua_settings = {
--   Lua = {
--     runtime = {
--       -- LuaJIT in the case of Neovim
--       version = "LuaJIT",
--       path = vim.split(package.path, ";")
--     },
--     diagnostics = {
--       -- Get the language server to recognize the `vim` global
--       globals = {"vim", "Reload", "P"}
--     },
--     workspace = {
--       -- Make the server aware of Neovim runtime files
--       library = {
--         [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--         [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
--       }
--     }
--   }
-- }
--
-- -- config that activates keymaps and enables snippet support
-- local function make_config()
--   local capabilities = vim.lsp.protocol.make_client_capabilities()
--   capabilities = vim.tbl_deep_extend("keep", capabilities, nvim_status.capabilities)
--   capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
--   capabilities.textDocument.completion.completionItem.snippetSupport = true
--   capabilities.textDocument.codeLens = {dynamicRegistration = false}
--   capabilities.textDocument.colorProvider = {dynamicRegistration = false}
--   capabilities.textDocument.completion.completionItem.snippetSupport = true
--   capabilities.textDocument.completion.completionItem.resolveSupport = {
--     properties = {
--       "documentation",
--       "detail",
--       "additionalTextEdits"
--     }
--   }
--
--   return {
--     -- enable snippet support
--     capabilities = capabilities,
--     -- map buffer local keybindings when the language server attaches
--     on_attach = on_attach
--   }
-- end
--
-- local diagnosticls_settings = {
--   filetypes = {
--     "javascript",
--     "javascriptreact",
--     "javascript.jsx",
--     "typescript",
--     "typescriptreact",
--     "typescript.tsx",
--     "html",
--     "css",
--     "sh"
--   },
--   init_options = {
--     linters = {
--       eslint = {
--         sourceName = "eslint",
--         command = "eslint_d",
--         rootPatterns = {
--           ".git",
--           ".eslintrc",
--           ".eslintrc.json",
--           ".eslintrc.js",
--           ".eslintrc.yml",
--           ".eslintrc.yaml",
--           "package.json"
--         },
--         debounce = 100,
--         args = {"-f", "unix", "--stdin", "--stdin-filename", "%filepath", "--format", "json"},
--         securities = {["1"] = "warning", ["2"] = "error"},
--         parseJson = {
--           errorsRoot = "[0].messages",
--           line = "line",
--           column = "column",
--           endLine = "endLine",
--           endColumn = "endColumn",
--           security = "severity",
--           message = "${message} [${ruleId}]"
--         }
--       },
--       shellcheck = {
--         sourceName = "shellcheck",
--         command = "shellcheck",
--         debounce = 100,
--         args = {"--format=gcc", "-"},
--         offsetLine = 0,
--         offsetColumn = 0,
--         formatLines = 1,
--         formatPattern = {
--           "^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$",
--           {line = 1, column = 2, message = 4, security = 3}
--         },
--         securities = {error = "error", warning = "warning", note = "info"}
--       }
--     },
--     formatters = {
--       prettier = {
--         command = "./node_modules/.bin/prettier",
--         args = {"--stdin-filepath", "%filepath"},
--         rootPatterns = {
--           ".git",
--           ".eslintrc.json",
--           ".eslintrc",
--           ".eslinrc.js",
--           "package.json",
--           ".prettierrc"
--         }
--       }
--     },
--     filetypes = {
--       sh = "shellcheck",
--       javascript = "eslint",
--       javascriptreact = "eslint",
--       ["javascript.jsx"] = "eslint",
--       typescript = "eslint",
--       typescriptreact = "eslint",
--       ["typescript.tsx"] = "eslint"
--     },
--     formatFiletypes = {
--       javascript = "eslint_d",
--       typescript = "eslint_d"
--     }
--   }
-- }
--
-- local function setup_servers()
--   if not lspconfig.golangcilsp then
--     configs.golangcilsp = {
--       default_config = {
--         cmd = {"golangci-lint-langserver"},
--         root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
--         init_options = {
--           command = {"golangci-lint", "run", "--enable-all", "--disable", "lll", "--out-format", "json"}
--         }
--       }
--     }
--   end
--   require "lspinstall".setup()
--   local servers = require "lspinstall".installed_servers()
--   table.insert(servers, "golangcilsp")
--   table.insert(servers, "diagnosticls")
--
--   for _, server in pairs(servers) do
--     local config = make_config()
--     if server == "lua" then
--       config.settings = lua_settings
--       config.root_dir = function(fname)
--         return lspconfig.util.find_git_ancestor(fname) or lspconfig.util.path.dirname(fname)
--       end
--     end
--
--     if server == "tailwindcss" then
--       config.filetypes = {"html", "typescriptreact"}
--       config.root_dir = lspconfig.util.root_pattern("package.json", ".git")
--     end
--
--     if server == "golangcilsp" then
--       config.filetypes = {"go"}
--     end
--
--     if server == "diagnosticls" then
--       config = diagnosticls_settings
--     end
--
--     if server == "go" then
--       config.root_dir = function(fname)
--         local Path = require "plenary.path"
--
--         local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
--         local absolute_fname = Path:new(fname):absolute()
--
--         if string.find(absolute_cwd, "/cmd/", 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
--           return absolute_cwd
--         end
--
--         return lspconfig.util.root_pattern("go.mod", ".git")(fname)
--       end
--       config.settings = {
--         gopls = {
--           codelenses = {test = true},
--           analyses = {
--             unusedparams = true
--           },
--           staticcheck = true
--         }
--       }
--     end
--
--     if server == "typescript" then
--       config.filetypes = {
--         "javascript",
--         "javascriptreact",
--         "javascript.jsx",
--         "typescript",
--         "typescriptreact",
--         "typescript.tsx"
--       }
--     end
--
--     require "lspconfig"[server].setup(config)
--   end
-- end
--
-- setup_servers()
--
-- -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
-- require "lspinstall".post_install_hook = function()
--   setup_servers() -- reload installed servers
--   vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
-- end
--
-- vim.api.nvim_command("command! LspCapabilities lua require'modules.lsp.capabilities'()")
