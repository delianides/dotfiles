local M = {}

local status = require "core.status"

function M.config()
  local status_ok, lualine = pcall(require, "lualine")
  local navic_ok, navic = pcall(require, "nvim-navic")
  if not navic_ok then
    return
  end
  if not status_ok then
    return
  end

  local colors = {
    bg = "#202328",
    fg = "#bbc2cf",
    yellow = "#ECBE7B",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#98be65",
    orange = "#FF8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67",
  }

  local conditions = {
    buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand "%:t") ~= 1
    end,
    hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
      local filepath = vim.fn.expand "%:p:h"
      local gitdir = vim.fn.finddir(".git", filepath .. ";")
      return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
  }

  local settings = {
    options = {
      theme = "kanagawa",
      icons_enabled = true,
      component_separators = "",
      section_separators = "",
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {},
      lualine_x = {},
    },
    winbar = {
      lualine_c = {},
    },
  }

  local function ins_left(component)
    table.insert(settings.sections.lualine_c, component)
  end

  local function ins_right(component)
    table.insert(settings.sections.lualine_x, component)
  end

  local function ins_wb(component)
    table.insert(settings.winbar.lualine_c, component)
  end

  ins_left {
    "branch",
    icon = "",
    color = { fg = colors.violet, gui = "bold" },
    padding = { left = 2, right = 1 },
  }

  ins_left {
    "filetype",
    cond = conditions.buffer_not_empty,
    color = { fg = colors.magenta, gui = "bold" },
    padding = { left = 2, right = 1 },
  }

  ins_left {
    "diff",
    symbols = { added = " ", modified = "柳", removed = " " },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow_1 },
      removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
    padding = { left = 2, right = 1 },
  }

  ins_left {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    diagnostics_color = {
      color_error = { fg = colors.red },
      color_warn = { fg = colors.yellow },
      color_info = { fg = colors.cyan },
    },
    padding = { left = 2, right = 1 },
  }

  ins_left {
    function()
      return "%="
    end,
  }

  ins_right {
    "filename",
    padding = { left = 1, right = 3 },
    path = 1,
  }

  -- ins_right {
  --   status.lsp_progress,
  --   color = { gui = "none" },
  --   padding = { left = 0, right = 1 },
  --   cond = conditions.hide_in_width,
  -- }

  ins_right {
    status.lsp_name,
    icon = " ",
    color = { gui = "none" },
    padding = { left = 0, right = 1 },
    cond = conditions.hide_in_width,
  }

  ins_right {
    status.treesitter_status,
    color = { fg = colors.green },
    padding = { left = 1, right = 0 },
    cond = conditions.hide_in_width,
  }

  ins_right {
    "location",
    padding = { left = 1, right = 1 },
  }

  ins_right {
    "progress",
    color = { gui = "none" },
    padding = { left = 0, right = 0 },
  }

  ins_right {
    status.progress_bar,
    padding = { left = 1, right = 1 },
    color = { fg = colors.yellow },
    cond = nil,
  }

  ins_right {
    function()
      return "▊"
    end,
    color = { fg = colors.blue },
    padding = { left = 1, right = 0 },
  }

  ins_wb {
    navic.get_location,
    cond = navic.is_available,
  }

  ins_wb {
    function()
      return "%="
    end,
  }

  lualine.setup(settings)
end

return M
