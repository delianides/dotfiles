-- luacheck: globals rex
-- Rex configuration. Migrated from config/ghostty/config.
--
-- Rex reads this file on `rex config reload` (it does not watch for changes).
-- Check it with `rex config check` and inspect the result with `rex keymap`.
--
-- Appearance (font, theme, line height, ligatures) is not configured here.
-- It lives in Rex Settings > Terminal, stored in the com.superlogical.rex
-- defaults domain. Ghostty equivalents that have no Rex setting yet:
-- window-padding-*, background-blur-radius, scrollback-limit,
-- mouse-hide-while-typing, window-save-state, macos-option-as-alt,
-- toggle_quick_terminal.

-- ctrl+a and ctrl+hjkl are deliberately not bound here so they reach the
-- terminal program (ctrl+hjkl is nvim-aware pane navigation via smart-splits).
-- Rex does not bind them by default, so nothing needs to be unbound.

-- Splits / panes
rex.bind("cmd+d", "pane.split", { direction = "right" })
rex.bind("cmd+shift+d", "pane.split", { direction = "down" })
rex.bind("cmd+shift+enter", "pane.zoom")

-- tmux-style movement. Same keys cmux bound in cmux.json (focusLeft etc.):
-- cmd+ctrl+hjkl focuses the neighbouring pane, for panes where ctrl+hjkl
-- belongs to the program (Claude Code, browsers). Add shift to move the pane
-- itself, like tmux swap-pane.
rex.bind("ctrl+h", "pane.focus", { direction = "left" })
rex.bind("ctrl+j", "pane.focus", { direction = "down" })
rex.bind("ctrl+k", "pane.focus", { direction = "up" })
rex.bind("ctrl+l", "pane.focus", { direction = "right" })
rex.bind("cmd+ctrl+shift+h", "pane.move", { direction = "left" })
rex.bind("cmd+ctrl+shift+j", "pane.move", { direction = "down" })
rex.bind("cmd+ctrl+shift+k", "pane.move", { direction = "up" })
rex.bind("cmd+ctrl+shift+l", "pane.move", { direction = "right" })

-- Resize mode, like tmux's repeatable `prefix + arrows`. cmd+r enters it;
-- hjkl or the arrows resize, shift for bigger steps, = balances, and
-- enter/escape leave. Exclusive so stray keys don't reach the terminal.
rex.mode("resize", { exclusive = true })
rex.bind("cmd+r", "client.mode.enter", { name = "resize" })
for key, direction in pairs { h = "left", j = "down", k = "up", l = "right" } do
  rex.bind("resize/" .. key, "pane.resize", { direction = direction })
  rex.bind("resize/" .. direction, "pane.resize", { direction = direction })
  rex.bind("resize/shift+" .. key, "pane.resize", { direction = direction, amount = 15 })
  rex.bind("resize/shift+" .. direction, "pane.resize", { direction = direction, amount = 15 })
end
rex.bind("resize/=", "pane.balance")
rex.bind("resize/enter", "client.mode.exit")

-- Tabs
rex.bind("cmd+t", "client.tab.new")
rex.bind("cmd+shift+[", "client.tab.previous")
rex.bind("cmd+shift+]", "client.tab.next")
for i = 1, 8 do
  rex.bind("cmd+" .. i, "client.tab.goto", { index = i })
end
rex.bind("cmd+9", "client.tab.goto", { index = -1 })

-- Windows
rex.bind("cmd+n", "client.window.new")

-- Misc
rex.bind("cmd+shift+k", "com.superlogical.terminal.clear")
