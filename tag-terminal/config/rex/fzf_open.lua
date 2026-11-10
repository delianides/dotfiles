-- luacheck: globals rex
-- fzf_open finds files under the focused pane's directory in a floating fzf
-- and opens the picks in $VISUAL in a new split to the right of that pane:
--   rex do fzf_open
-- tab marks several files, enter opens them, escape closes the float.
-- The file list is FZF_DEFAULT_COMMAND from ~/.zshenv (rg, ~/.config/fzf/ignore).

-- block_cwd returns the working directory of the program in the foreground of
-- a terminal block. The terminal's pwd method is empty under zsh (no OSC 7).
local function block_cwd(block_id)
  local p = block_id and rex.block.call("com.superlogical.terminal", "process", { block_id = block_id })
  return p and p.foreground and p.foreground.cwd or os.getenv "HOME"
end

-- The float runs a login zsh without ~/.zshrc so it opens fast. The editor
-- split uses --interactive, so it gets VISUAL (neorex inside Rex) and the
-- rest of the interactive environment. fzf's become replaces fzf with the
-- rex split call, and the float closes when that returns.
local PICKER = [[
cd -- "$2" || exit
export FZF_OPEN_ANCHOR="$1" FZF_OPEN_CWD="$2"
export FZF_OPEN_EDIT='exec "${VISUAL:-${EDITOR:-nvim}}" "$@"'
exec fzf --multi --prompt "${(D)2}/ " \
  --preview 'bat --color=always --style=numbers --line-range=:300 {}' \
  --bind 'enter:become(rex split -b "$FZF_OPEN_ANCHOR" -c "$FZF_OPEN_CWD" --interactive -- zsh -c "$FZF_OPEN_EDIT" zsh {+})'
]]

rex.action {
  name = "fzf_open",
  title = "Find File",
  description = "Search the focused pane's directory with fzf in a floating pane and open the pick in a split beside it.",
  category = "Files",
  keywords = "fzf find file open search fuzzy editor nvim neorex float popup",
  run = function(ctx)
    local cwd = block_cwd(ctx.block_id)
    local l, err = rex.session.new_layer {
      session_id = ctx.session_id,
      window_id = ctx.window_id,
      bounds = { 0.1, 0.1, 0.8, 0.8 },
      focus = true,
      layout = rex.layout.block {
        flavor = "com.superlogical.terminal.shell",
        label = "find file",
        options = {
          cwd = cwd,
          shell = "none",
          command = { "/bin/zsh", "-lc", PICKER, "fzf_open", ctx.block_id or "", cwd },
        },
      },
    }
    if err ~= nil then
      error(err, 0)
    end
    return { layer_id = l.layer_id, block_id = l.block_ids[1], cwd = cwd }
  end,
}

rex.bind("ctrl+a>f", "fzf_open")
