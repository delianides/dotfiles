local M = {}

local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end

local conf = require("telescope.config").values
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"
local actions = require "telescope.actions"
local builtin = require "telescope.builtin"

local layout_config = {
    horizontal = {
        preview_width = 0.4,
    },
    vertical = {
        preview_cutoff = 43, -- height of 13" monitor, scentifically measured
        preview_height = 0.4,
    },
}

function M.config()
  telescope.setup {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "❯ ",
      selection_caret = " ",

      winblend = 0,

      layout_strategy = "horizontal",
      border = {},

      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      scroll_strategy = "cycle",
      color_devicons = true,

      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules", ".yalc" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,

      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      path_display = { "truncate" },
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-c>"] = actions.close,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,

          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-l>"] = actions.complete_tag,
        },

        n = {
          ["<esc>"] = actions.close,
          ["<C-c>"] = actions.close,

          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,
        },
      },
    },

    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
      project = {
        base_dirs = {
          '~/Code/src',
          '~/Code/personal',
          '~/Code/work'
        },
        hidden_files = true,
        theme = "dropdown"
      }
    },
  }

  telescope.load_extension "fzy_native"
  telescope.load_extension "file_browser"
  telescope.load_extension "project"
  telescope.load_extension "git_worktree"
end

function M.project_files(opts)
  opts = opts or {}

  -- luacheck: ignore _git_pwd
  local _git_pwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

  if vim.v.shell_error ~= 0 then
    local client = vim.lsp.get_active_clients()[1]
    if client then
      opts.cwd = client.config.root_dir
    end
    builtin.find_files(opts)
    return
  end

  builtin.git_files(opts)
end

function M.project_grep()
  local opts = {}
  -- luacheck: ignore _git_pwd
  local _git_pwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

  if vim.v.shell_error ~= 0 then
    local client = vim.lsp.get_active_clients()[1]
    if client then
      opts.cwd = client.config.root_dir
    end
  else
    opts.cwd = _git_pwd
  end

  builtin.live_grep {
    prompt_tiles = [[\ Find in Files /]],
    cwd = opts.cwd,
  }
end

M.find = function(opts)
    opts = vim.tbl_extend("force", {
        layout_config = layout_config,
        hidden = true,
    }, opts or {})
    if opts.use_buffer_cwd then
        opts.cwd = vim.fn.expand "%:p:h"
    end
    builtin.find_files(opts)
end

M.grep = function(opts)
    opts = opts or {}
    local search = vim.fn.input "Grep >"
    local cwd = opts.use_buffer_cwd and vim.fn.expand "%:p:h" or nil
    if cwd == "" then
        -- we expanded to nothing - default to cwd
        cwd = vim.loop.cwd()
    end
    if search ~= "" then
        builtin.grep_string {
            cwd = cwd,
            only_sort_text = true,
            search = search,
            use_regex = true,
            disable_coordinates = true,
            layout_strategy = "vertical",
            layout_config = {
                prompt_position = "top",
                mirror = true,
                preview_cutoff = 0,
                preview_height = 0.2,
            },
        }
    else
        builtin.live_grep {
            cwd = cwd,
            layout_strategy = "vertical",
            layout_config = {
                prompt_position = "top",
                mirror = true,
                preview_cutoff = 0,
                preview_height = 0.2,
            },
        }
    end
end

M.oldfiles = function()
    builtin.oldfiles { layout_config = layout_config }
end

M.current_buffer_fuzzy_find = function()
    builtin.current_buffer_fuzzy_find {
        layout_strategy = "vertical",
        preview_height = 0.4,
    }
end

M.project = function()
    telescope.extensions.project.project {
        display_type = "full",
    }
end

M.buffers = function()
    builtin.buffers { layout_config = layout_config }
end

M.git_files = function(opts)
    opts = vim.tbl_extend("force", {
        layout_config = layout_config,
    }, opts or {})
    if opts.use_buffer_cwd then
        -- TODO: This doesn't seem to work?
        opts.cwd = vim.fn.expand "%:p:h"
    end
    builtin.git_files(opts)
end

M.document_diagnostics = function()
  builtin.diagnostics { bufnr = 0 }
end

M.workspace_diagnostics = function()
  builtin.diagnostics()
end

M.definitions = function()
  builtin.lsp_definitions()
end

M.references = function()
  builtin.lsp_references()
end

M.buffer_references = function(opts)
  opts = opts or {}
  local params = vim.lsp.util.make_position_params(opts.winnr)
  params.context = { includeDeclaration = true }

  vim.lsp.buf_request(opts.bufnr, "textDocument/references", params, function(err, result, ctx, _config)
    if err then
      vim.api.nvim_err_writeln("Error when finding references: " .. err.message)
      return
    end

    local locations = {}
    if result then
      local filtered_result = result
      local buf_uri = vim.uri_from_bufnr(0)
      filtered_result = vim.tbl_filter(function(location)
        return (location.uri or location.targetUri) == buf_uri
      end, result)

      locations = vim.lsp.util.locations_to_items(
      filtered_result,
      vim.lsp.get_client_by_id(ctx.client_id).offset_encoding
      ) or {}
    end

    if vim.tbl_isempty(locations) then
      return
    end

    pickers.new(opts, {
      prompt_title = "LSP References (filtered)",
      finder = finders.new_table {
        results = locations,
        entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts),
      },
      previewer = conf.qflist_previewer(opts),
      sorter = conf.generic_sorter(opts),
    }):find()
  end)
end

M.implementations = function()
  builtin.lsp_implementations()
end

M.workspace_symbols = function()
  local query = vim.fn.input "Query >"
  if query ~= "" then
    vim.cmd("Telescope lsp_workspace_symbols query=" .. query)
  else
    builtin.lsp_workspace_symbols()
  end
end

M.document_symbols = function()
  local symbols = {
    "All",
    "Variable",
    "Function",
    "Constant",
    "Class",
    "Property",
    "Method",
    "Enum",
    "Interface",
    "Boolean",
    "Number",
    "String",
    "Array",
    "Constructor",
  }

  vim.ui.select(symbols, { prompt = "Select which symbol" }, function(item)
    if item == "All" then
      builtin.lsp_document_symbols()
    else
      builtin.lsp_document_symbols { symbols = item }
    end
  end)
end

M.stash = function()
    builtin.git_stash {
        layout_strategy = "flex",
        layout_config = {
            flex = {
                flip_columns = 161, -- half 27" monitor, scientifically calculated
            },
            horizontal = {
                preview_cutoff = 0,
                preview_width = { padding = 17 },
            },
            vertical = {
                preview_cutoff = 0,
                preview_height = { padding = 5 },
            },
        },
    }
end

return M
