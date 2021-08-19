if not pcall(require, "telescope") then
  return
end

local should_reload = true
local reloader = function()
  if should_reload then
    RELOAD "plenary"
    RELOAD "popup"
    RELOAD "telescope"
  end
end

reloader()

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local action_mt = require "telescope.actions.mt"
local sorters = require "telescope.sorters"
local themes = require "telescope.themes"

local set_prompt_to_entry_value = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == "table" then
    return
  end

  action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

-- local action_set = require('telescope.actions.set')
local _ = pcall(require, "nvim-nonicons")

TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format("<cmd>lua R('modules.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end


require("telescope").setup {
  defaults = {
    prompt_prefix = "❯ ",
    selection_caret = "❯ ",

    winblend = 0,

    layout_strategy = "horizontal",
    layout_config = {
      width = 0.95,
      height = 0.85,
      -- preview_cutoff = 120,
      prompt_position = "top",

      horizontal = {
        -- width_padding = 0.1,
        -- height_padding = 0.1,
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },

      vertical = {
        -- width_padding = 0.05,
        -- height_padding = 1,
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },

      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },

    selection_strategy = "reset",
    sorting_strategy = "descending",
    scroll_strategy = "cycle",
    color_devicons = true,

    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-s>"] = actions.select_horizontal,

        ["<C-y>"] = set_prompt_to_entry_value,

        -- ["<M-m>"] = actions.master_stack,

        -- Experimental
        -- ["<tab>"] = actions.toggle_selection,

        -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },

    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

    -- file_sorter = sorters.get_fzy_sorter,
    file_ignore_patterns = {
      -- "parser.c",
      -- "mock_.*.go",
    },

    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  },

  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },

    fzf_writer = {
      use_highlighter = false,
      minimum_grep_characters = 6,
    },

    frecency = {
      workspaces = {
        ["conf"] = "/home/tj/.config/nvim/",
        ["nvim"] = "/home/tj/build/neovim",
      },
    },
  },
}

-- Load the fzy native extension at the start.
pcall(require("telescope").load_extension, "cheat")
pcall(require("telescope").load_extension, "dap")
pcall(require("telescope").load_extension, "arecibo")
pcall(require("telescope").load_extension, "flutter")

-- pcall(require("telescope").load_extension, "fzy_native")
pcall(require("telescope").load_extension, "fzf")

if vim.fn.executable "gh" == 1 then
  pcall(require("telescope").load_extension, "gh")
  pcall(require("telescope").load_extension, "octo")
end
pcall(require("telescope").load_extension, "git_worktree")

if pcall(require("telescope").load_extension, "frecency") then
  require "tj.telescope.frecency"
end

local M = {}

function M.edit_zsh()
  require("telescope.builtin").find_files {
    shorten_path = false,
    cwd = "~/.config/zsh/",
    prompt = "~ dotfiles ~",
    hidden = true,

    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.55,
    },
  }
end

function M.fd()
  require("telescope.builtin").fd()
end

function M.builtin()
  require("telescope.builtin").builtin()
end

function M.git_files()
  local path = vim.fn.expand "%:h"

  local width = 0.25
  if string.find(path, "sourcegraph.*sourcegraph", 1, false) then
    width = 0.5
  end

  local opts = themes.get_dropdown {
    winblend = 5,
    previewer = false,
    shorten_path = false,

    cwd = path,

    layout_config = {
      width = width,
    },
  }

  require("telescope.builtin").git_files(opts)
end

function M.buffer_git_files()
  require("telescope.builtin").git_files(themes.get_dropdown {
    cwd = vim.fn.expand "%:p:h",
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  })
end

function M.lsp_code_actions()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  require("telescope.builtin").lsp_code_actions(opts)
end

function M.live_grep()
  require("telescope").extensions.fzf_writer.staged_grep {
    shorten_path = true,
    previewer = false,
    fzf_separator = "|>",
  }
end

function M.grep_prompt()
  require("telescope.builtin").grep_string {
    shorten_path = true,
    search = vim.fn.input "Grep String > ",
  }
end

function M.grep_last_search(opts)
  opts = opts or {}

  -- \<getreg\>\C
  -- -> Subs out the search things
  local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")

  opts.shorten_path = true
  opts.word_match = "-w"
  opts.search = register

  require("telescope.builtin").grep_string(opts)
end

function M.project_search()
  require("telescope.builtin").find_files {
    previewer = false,
    layout_strategy = "vertical",
    cwd = require("lspconfig.util").root_pattern ".git"(vim.fn.expand "%:p"),
  }
end

function M.buffers()
  require("telescope.builtin").buffers {
    shorten_path = false,
  }
end

function M.git_status()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  -- Can change the git icons using this.
  -- opts.git_icons = {
  --   changed = "M"
  -- }

  require("telescope.builtin").git_status(opts)
end

function M.git_commits()
  require("telescope.builtin").git_commits {
    winblend = 5,
  }
end

vim.api.nvim_set_keymap("c", "<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", { noremap = false, nowait = true })

-- Dotfiles
map_tele("<leader>en", "edit_neovim")
map_tele("<leader>ez", "edit_zsh")

-- Search
-- TODO: I would like to completely remove _mock from my search results here when I'm in SG/SG
map_tele("<space>gw", "grep_string", {
  short_path = true,
  word_match = "-w",
  only_sort_text = true,
  layout_strategy = "vertical",
  sorter = sorters.get_fzy_sorter(),
})

map_tele("<space>f/", "grep_last_search", {
  layout_strategy = "vertical",
})

-- Files
-- map_tele("<C-f>", "git_files")
-- map_tele("<space>fg", "live_grep")
map_tele("<space>fg", "multi_rg")
map_tele("<space>fo", "oldfiles")
map_tele("<space>fd", "fd")
map_tele("<C-f>", "project_search")
map_tele("<space>fv", "find_nvim_source")
map_tele("<space>fe", "file_browser")
map_tele("<space>fz", "search_only_certain_files")

-- Sourcegraph
map_tele("<space>sf", "sourcegraph_find")
map_tele("<space>saf", "sourcegraph_about_find")
map_tele("<space>sag", "sourcegraph_about_grep")
-- map_tele('<space>fz', 'sourcegraph_tips')

-- Git
map_tele("<space>gs", "git_status")
map_tele("<space>gc", "git_commits")

-- Nvim
map_tele("<space>fb", "buffers")
map_tele("<space>fp", "my_plugins")
map_tele("<space>fa", "installed_plugins")
map_tele("<space>fi", "search_all_files")
map_tele("<space>ff", "curbuf")
map_tele("<space>fh", "help_tags")
map_tele("<space>vo", "vim_options")
map_tele("<space>gp", "grep_prompt")

-- Telescope Meta
map_tele("<space>fB", "builtin")

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    if M[k] then
      return M[k]
    else
      return require("telescope.builtin")[k]
    end
  end,
})
