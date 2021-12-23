vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp = require "cmp"
local lspkind = require "lspkind"
local luasnip = require "luasnip"
local utils = require "util"
local t = utils.t
local fn = vim.fn
local api = vim.api

lspkind.init()

cmp.setup {
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  snippet = {
    expand = function(args)
      -- For `luasnip` user.
      require("luasnip").lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        path = "[path]",
        luasnip = "[snip]",
      },
    },
  },
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = function(fallback)
      if luasnip.expand_or_jumpable() then
        fn.feedkeys(t "<Plug>luasnip-expand-or-jump", "")
      elseif fn.pumvisible() == 1 then
        fn.feedkeys(t "<C-n>", "n")
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if luasnip.jumpable(-1) then
        fn.feedkeys(t "<Plug>luasnip-jump-prev", "")
      elseif fn.pumvisible() == 1 then
        fn.feedkeys(t "<C-p>", "n")
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 5 },
  },
  experimental = {
    -- I like the new menu better! Nice work hrsh7th
    native_menu = false,
    -- Let's play with this for a day or two
    ghost_text = true,
  },
}
