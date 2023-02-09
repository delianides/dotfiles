return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "hrsh7th/cmp-cmdline",
        config = function()
          local cmp = require("cmp")
          cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = "buffer" } },
          })

          cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
          })
        end,
      },
    },
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }

      opts.formatting = {
        fields = { "abbr", "kind", "menu" },
        format = lspkind.cmp_format({
          mode = "symbol_text",
          symbol_map = {
            Copilot = "",
          },
          before = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        }),
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      {
        "theHamsta/nvim-dap-virtual-text",
        config = true,
      },
    },
    config = function()
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })
      require("dap").defaults.fallback.terminal_win_cmd = "enew"
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dap-repl",
        callback = function()
          require("dap.ext.autocompl").attach()
        end,
      })
      require("which-key").register({
        ["<leader>db"] = { name = "+breakpoints" },
        ["<leader>ds"] = { name = "+steps" },
        ["<leader>dv"] = { name = "+views" },
      })
    end,
    keys = {
      {
        "<leader>dbc",
        '<CMD>lua require("dap").set_breakpoint(vim.ui.input("Breakpoint condition: "))<CR>',
        desc = "conditional breakpoint",
      },
      {
        "<leader>dbl",
        '<CMD>lua require("dap").set_breakpoint(nil, nil, vim.ui.input("Log point message: "))<CR>',
        desc = "logpoint",
      },
      { "<leader>dbr", '<CMD>lua require("dap.breakpoints").clear()<CR>', desc = "remove all" },
      { "<leader>dbs", "<CMD>Telescope dap list_breakpoints<CR>", desc = "show all" },
      { "<leader>dbt", '<CMD>lua require("dap").toggle_breakpoint()<CR>', desc = "toggle breakpoint" },
      { "<leader>dc", '<CMD>lua require("dap").continue()<CR>', desc = "continue" },
      {
        "<leader>de",
        '<CMD>lua require("dap.ui.widgets").hover(nil, { border = "none" })<CR>',
        desc = "expression",
        mode = { "n", "v" },
      },
      { "<leader>dp", '<CMD>lua require("dap").pause()<CR>', desc = "pause" },
      { "<leader>dr", "<CMD>Telescope dap configurations<CR>", desc = "run" },
      { "<leader>dsb", '<CMD>lua require("dap").step_back()<CR>', desc = "step back" },
      { "<leader>dsc", '<CMD>lua require("dap").run_to_cursor()<CR>', desc = "step to cursor" },
      { "<leader>dsi", '<CMD>lua require("dap").step_into()<CR>', desc = "step into" },
      { "<leader>dso", '<CMD>lua require("dap").step_over()<CR>', desc = "step over" },
      { "<leader>dsx", '<CMD>lua require("dap").step_out()<CR>', desc = "step out" },
      { "<leader>dx", '<CMD>lua require("dap").terminate()<CR>', desc = "terminate" },
      {
        "<leader>dvf",
        '<CMD>lua require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames, { border = "none" })<CR>',
        desc = "show frames",
      },
      {
        "<leader>dvs",
        '<CMD>lua require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes, { border = "none" })<CR>',
        desc = "show scopes",
      },
      {
        "<leader>dvt",
        '<CMD>lua require("dap.ui.widgets").centered_float(require("dap.ui.widgets").threads, { border = "none" })<CR>',
        desc = "show threads",
      },
    },
  },
}
