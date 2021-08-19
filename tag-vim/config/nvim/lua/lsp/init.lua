local saga = require 'lspsaga'
local status = require "lsp.status"
local nvim_status = require "lsp-status"
local handlers = require "lsp.handlers"
local lspkind = require "lspkind"

local inoremap = vim.keymap.inoremap
local nnoremap = vim.keymap.nnoremap
local vnoremap = vim.keymap.vnoremap

local filetype_attach = setmetatable({
  go = function()
    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
      augroup END
    ]]
  end,
  rust = function()
    vim.cmd [[
      autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request {aligned = true, prefix = " » "}
    ]]

    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting(nil, 5000)
      augroup END
    ]]
  end,
},{
  __index = function()
    return function()
    end
  end,
})

lspkind.init()
status.activate()
saga.init_lsp_saga {
  error_sign = 'E',
  warn_sign = 'W',
  hint_sign = 'H',
  infor_sign = 'I',
}

local nvim_exec = function(txt)
  vim.api.nvim_exec(txt, false)
end

local buf_nnoremap = function(opts)
  opts.buffer = 0
  nnoremap(opts)
end

local buf_inoremap = function(opts)
  opts.buffer = 0
  inoremap(opts)
end

local buf_vnoremap = function(opts)
  opts.buffer = 0
  vnoremap(opts)
end

local on_attach = function(client, bufnr)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  nvim_status.on_attach(client)

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.

  buf_nnoremap { "[e", '<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()<CR>' }
  buf_nnoremap { "]e", '<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_next()<CR>' }
  buf_nnoremap { "<Leader>sl", '<cmd>lua require"lspsaga.diagnostic".show_line_diagnostics()<CR>' }
  buf_nnoremap { "<Leader>sc", '<cmd>lua require"lspsaga.diagnostic".show_cursor_diagnostics()<CR>' }

  buf_nnoremap { "<Leader>cr", '<cmd>lua require("lspsaga.rename").rename()<CR>' }

  buf_nnoremap { "<space>gI", handlers.implementation }
  buf_inoremap { "gs", '<cmd>lua require"lspsaga.signaturehelp".signature_help()<CR>' }
  buf_nnoremap { "gd", vim.lsp.buf.definition }
  buf_nnoremap { "pd", '<cmd>lua require"lspsaga.provider".preview_definition()<CR>' }
  buf_nnoremap { "gh", '<cmd>lua require"lspsaga.provider".lsp_finder<CR>' }
  buf_nnoremap { "gD", vim.lsp.buf.declaration }
  buf_nnoremap { "gT", vim.lsp.buf.type_definition }

  buf_nnoremap { "<Leader>wa", vim.lsp.buf.add_workspace_folder }
  buf_nnoremap { "<Leader>wr", vim.lsp.buf.remove_workspace_folder }
  buf_nnoremap { "<Leader>rn", vim.lsp.buf.rename }
  buf_nnoremap { "<Leader>P", vim.lsp.buf.formatting }
  buf_vnoremap { "<Leader>p", vim.lsp.buf.range_formatting }
  buf_nnoremap { "<Leader>l", vim.lsp.codelens.run }

  -- vim already has builtin docs
  if vim.bo.ft ~= "vim" then buf_nnoremap { "H", '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>' } end

  -- wont keep these arrows as the map but just testing for now
  buf_nnoremap { "<C-b>", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>' }
  buf_nnoremap { "<C-f>", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>' }

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    nvim_exec [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  if client.resolved_capabilities.code_lens then
    vim.cmd [[
    augroup lsp_codelens
      autocmd! * <buffer>
      autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
    augroup END
    ]]
  end

  if client.server_capabilities.colorProvider then
    require"lsp-documentcolors".buf_attach(bufnr, { single_column = true })
  end

  filetype_attach[filetype](client)
end

-- Configure lua language server for neovim development
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = "LuaJIT",
      path = vim.split(package.path, ";"),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {'vim', 'Reload', 'P'},
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
      },
    },
  },
}

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("keep", capabilities, nvim_status.capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.codeLens = { dynamicRegistration = false }
  capabilities.textDocument.colorProvider = { dynamicRegistration = false }
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    local config = make_config()
    if server == "efm" then config = vim.tbl_extend("force", config, require "lsp.efm") end
    if server == "lua" then
      config.settings = lua_settings
      config.root_dir = function(fname)
        local util = require "lspconfig/util"
        return util.find_git_ancestor(fname) or util.path.dirname(fname)
      end
    end

    if server == "go" then
      config.settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      }
      config.cmd = {"gopls", "serve"}
    end

    if server == "typescript" then
      config.filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      }
    end

    require'lspconfig'[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

vim.api.nvim_command("command! LspCapabilities lua require'lsp.capabilities'()")

