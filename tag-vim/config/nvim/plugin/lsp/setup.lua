local ok, util = pcall(require, "lspconfig.util")
if not ok then
  return
end

local wk = require("which-key")
local ts_utils = require("nvim-treesitter.ts_utils")
local lsp_signature = require("lsp_signature")
local null_ls = require("null-ls")
local navic = require("nvim-navic")

local telescope_config = require("configs.telescope")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
vim.api.nvim_create_user_command("LspLog", [[exe 'tabnew ' .. luaeval("vim.lsp.get_log_path()")]], {})

require("mason").setup({
  ui = {
    icons = {
      server_installed = "",
      server_pending = "",
      server_uninstalled = "",
    },
  },
})

require("mason-null-ls").setup({
  ensure_installed = { "actionlint", "prettierd" }
})

require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = {
    "sumneko_lua",
    "jsonls",
    "tsserver",
    "astro",
    -- "eslint",
    "prismals",
    "tailwindcss",
    "html",
    "cssls",
    "astro",
    "yamlls",
    "marksman",
    "dockerls",
  },
})

local function w(fn)
  return function()
    return fn()
  end
end

---@param opts table|nil
local function create_capabilities(opts)
  local default_opts = {
    with_snippet_support = true,
  }
  opts = opts or default_opts
  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = opts.with_snippet_support
  if opts.with_snippet_support then
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    }
  end
  return capabilities
end

local function highlight_references()
  local node = ts_utils.get_node_at_cursor()
  while node ~= nil do
    local node_type = node:type()
    if node_type == "string"
        or node_type == "string_fragment"
        or node_type == "template_string"
        or node_type == "document" -- for inline gql`` strings
    then
      -- who wants to highlight a string? i don't. yuck
      return
    end
    node = node:parent()
  end
  vim.lsp.buf.document_highlight()
end

---@param bufnr number
local function buf_autocmd_document_highlight(bufnr)
  local group = vim.api.nvim_create_augroup("lsp_document_highlight", {})
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    buffer = bufnr,
    group = group,
    callback = highlight_references,
  })
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    buffer = bufnr,
    group = group,
    callback = w(vim.lsp.buf.clear_references),
  })
end

---@param bufnr number
local function buf_autocmd_codelens(bufnr)
  local group = vim.api.nvim_create_augroup("lsp_document_codelens", {})
  vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost", "CursorHold" }, {
    buffer = bufnr,
    group = group,
    callback = w(vim.lsp.codelens.refresh),
  })
end

local function buf_run_prettier(bufnr)
  vim.g.should_run_prettier = true
  vim.lsp.buf.format({
    bufnr = bufnr,
    name = "null-ls",
  })
  vim.g.should_run_prettier = false
end

---@param bufnr number
local function buf_set_keymaps(bufnr)
  wk.register({
    l = {
      name = "+lsp",
      f = { vim.lsp.buf.format, "Select LSP to format buffer" }, -- create a binding with label
      r = { vim.lsp.buf.rename, "Rename variable with LSP" }, -- additional options for creating the keymap
      a = { vim.lsp.buf.code_action, "Run LSP Code Action" }, -- just a label. don't create any mapping
      s = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Signature Help" },
      O = { vim.lsp.buf.hover, "Hover" },
      d = {
        name = "+document",
        d = { "<cmd>Trouble document_diagnostics<CR>", "Trouble Document Diagnostics" },
        s = { telescope_config.document_symbols, "Telescope show document symbols" },
        t = { telescope_config.document_diagnostics, "Telescope show document diagnostics" },
        p = { buf_run_prettier, "Run Prettier" },
      },
      w = {
        name = "+workspace",
        w = { "<cmd>Trouble workspace_diagnostics<CR>", "Trouble Workspace Diagnostics" },
        s = { telescope_config.workspace_symbols, "Telescope show workspace symbols" },
        d = { telescope_config.workspace_diagnostics, "Telescope show workspace diagnostics" },
        o = { "<cmd>lua vim.diagnostics.open_float()<CR>", "Open Diagnostics Float" },
      },
      g = {
        name = "+definition",
        D = { vim.lsp.buf.declaration, "Show declaration of variable under cursor" },
        t = {
          name = "+telescope",
          d = { telescope_config.definitions, "Show LSP Definition" },
          r = { telescope_config.references, "Show LSP References" },
          b = { telescope_config.buffer_references, "Show Buffer LSP Reference" },
          i = { telescope_config.implementions, "Show LSP Implmentation" },
        },
      },
    },
  }, { prefix = "<leader>", buffer = bufnr })

  wk.register({
    d = {
      name = "+diagnostics",
      t = { "<cmd>Trouble document_diagnostics<CR>", "Trouble Document Diagnostics" },
      j = { vim.diagnostic.goto_next, "Goto Next Diagnostic" },
      k = { vim.diagnostic.goto_prev, "Goto Prev Diagnostic" },
      l = { "<cmd>Telescope diagnostics<cr>", "List all Diagnostics" },
    },
  }, { prefix = "<leader>", buffer = bufnr })

  wk.register({
    O = { "<cmd>Lspsaga hover_doc<CR>", "Hover" },
    g = {
      d = { vim.lsp.buf.definition, "Go to Definition" },
      D = {
        "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
        "Show Preview Definition",
      },
      i = {
        "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
        "Show Preview Implmentation",
      },
      q = { "<cmd>lua require('goto-preview').close_all_win()<CR>", "Close all Preview Windows" },
    },
  }, { prefix = "", buffer = bufnr })
end

local function common_on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  buf_set_keymaps(bufnr)

  if client.config.flags then
    client.config.flags.allow_incremkental_sync = true
  end

  if client.supports_method("textDocument/documentSymbol") then
    navic.attach(client, bufnr)
  end

  if client.supports_method("textDocument/documentHighlight") then
    buf_autocmd_document_highlight(bufnr)
  end

  if client.supports_method("textDocument/codeLens") then
    buf_autocmd_codelens(bufnr)
    vim.schedule(vim.lsp.codelens.refresh)
  end

  lsp_signature.on_attach({
    bind = true,
    floating_window = false,
    hint_prefix = "",
    hint_scheme = "Comment",
  }, bufnr)
end

util.on_setup = util.add_hook_after(util.on_setup, function(config)
  if config.on_attach then
    config.on_attach = util.add_hook_after(config.on_attach, common_on_attach)
  else
    config.on_attach = common_on_attach
  end
  config.capabilities = create_capabilities()
end)

null_ls.setup({
  debug = false,
  debounce = 150,
  save_after_format = false,
  sources = {
    -- null_ls.builtins.formatting.prettierd.with({
    --   runtime_condition = function()
    --     return vim.g.should_run_prettier
    --   end,
    -- }),
    null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.fixjson.with({ filetypes = { "jsonc" } }),
    null_ls.builtins.diagnostics.shellcheck,
    -- null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.luacheck.with({
      extra_args = { "--globals", "vim" },
    }),
    -- null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.code_actions.gitsigns,
    -- nls.builtins.diagnostics.selene,
  },
  on_attach = function(client, bufnr)
    -- requires neovim 0.8
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = augroup,
        buffer = bufnr,
        callback = function(opts)
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(clients)
              return clients.name ~= "tsserver"
            end,
          })
        end,
      })
    end
  end,
})
