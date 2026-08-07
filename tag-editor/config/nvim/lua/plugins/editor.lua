-- herdr is not one of smart-splits' built-in backends; the local implementation
-- lives in lua/smart-splits/mux/herdr.lua. Only select it when we're actually in
-- a herdr pane, so tmux/wezterm/kitty auto-detection still works elsewhere.
local function herdr_backend()
  local pane_id = vim.env.HERDR_PANE_ID
  if pane_id and #pane_id > 0 then
    return "herdr"
  end
  return nil
end

return {
  {
    "mrjones2014/smart-splits.nvim",
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
      at_edge = "stop",
      multiplexer_integration = herdr_backend(),
    },
  },
  {
    "max397574/better-escape.nvim",
    config = true,
  },
  {
    "TimUntersberger/neogit",
    keys = { { "<C-g>", "<cmd>Neogit kind=split<cr>", desc = "NeoGit" } },
    opts = {
      disable_signs = true,
      kind = "split",
      commit_popup = { kind = "split" },
      integrations = {
        diffview = true,
      },
      disable_builtin_notifications = true,
    },
    dependencies = { "sindrets/diffview.nvim" },
  },
}
