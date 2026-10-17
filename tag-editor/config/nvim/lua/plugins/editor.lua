return {
  {
    "smart-splits-nvim/smart-splits.nvim",
    lazy = false,
    keys = {
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Move to left split",
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "Move to below split",
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "Move to above split",
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "Move to right split",
      },
    },
    opts = {
      move = { at_edge = "stop" },
      mux = {
        -- Our own backend, lua/smart-splits-backend-cmux.lua. It detects cmux
        -- itself, so outside cmux movement just stops at Neovim's edges.
        backend = "smart-splits-backend-cmux",
        warn_if_unusable = false,
      },
    },
  },
  {
    "max397574/better-escape.nvim",
    config = true,
  },
}
