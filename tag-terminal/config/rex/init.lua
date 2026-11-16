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
for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
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

-- ===========================================================================
-- Migrated from tmux (~/.config/tmux/tmux.conf), prefix ctrl+a.
-- ctrl+a now starts a sequence, so ctrl+a ctrl+a sends ctrl+a to the program.
-- ctrl+a>c, ctrl+a>shift+', ctrl+a>shift+q, ctrl+a>shift+\ and ctrl+a>x are
-- in the Herdr section below (Herdr won those conflicts).
-- ===========================================================================
rex.bind("ctrl+a>ctrl+a", "pane.send_key", { key = "ctrl+a" }) -- tmux.conf:15
rex.bind("ctrl+a>shift+r", "client.config.reload") -- tmux.conf:17
rex.bind("ctrl+a>shift+5", "pane.split", { direction = "right" }) -- tmux.conf:65
rex.bind("ctrl+a>shift+a", "client.tab.new") -- tmux.conf:73
rex.bind("ctrl+a>b", "client.tab.new") -- tmux.conf:74
rex.bind("ctrl+a>shift+d", "client.tab.new") -- tmux.conf:75
rex.bind("ctrl+a>shift+e", "client.tab.new") -- tmux.conf:76
rex.bind("ctrl+a>g", "client.tab.new") -- tmux.conf:77
rex.bind("ctrl+a>shift+y", "pane.split", { direction = "down" }) -- tmux.conf:79
rex.bind("ctrl+a>shift+b", "pane.move_to_new_tab") -- tmux.conf:81
rex.bind("ctrl+a>h", "pane.focus", { direction = "left" }) -- tmux.conf:83
rex.bind("ctrl+a>j", "pane.focus", { direction = "down" }) -- tmux.conf:84
rex.bind("ctrl+a>k", "pane.focus", { direction = "up" }) -- tmux.conf:85
rex.bind("ctrl+a>l", "pane.focus", { direction = "right" }) -- tmux.conf:86
rex.bind("ctrl+a>shift+-", "pane.split", { direction = "down" }) -- tmux.conf:111

-- tmux `bind -r` (repeatable) resize: ctrl+a ctrl+r enters repeat mode,
-- enter or escape leaves.
rex.mode("repeat", { exclusive = true })
rex.bind("ctrl+a>ctrl+r", "client.mode.enter", { name = "repeat" })
rex.bind("repeat/enter", "client.mode.exit")
rex.bind("repeat/escape", "client.mode.exit")
rex.bind("ctrl+a>left", "pane.resize", { amount = 5, direction = "left" }) -- tmux.conf:114
rex.bind("repeat/left", "pane.resize", { amount = 5, direction = "left" }) -- tmux.conf:114
rex.bind("ctrl+a>up", "pane.resize", { amount = 5, direction = "up" }) -- tmux.conf:115
rex.bind("repeat/up", "pane.resize", { amount = 5, direction = "up" }) -- tmux.conf:115
rex.bind("ctrl+a>down", "pane.resize", { amount = 5, direction = "down" }) -- tmux.conf:116
rex.bind("repeat/down", "pane.resize", { amount = 5, direction = "down" }) -- tmux.conf:116
rex.bind("ctrl+a>right", "pane.resize", { amount = 5, direction = "right" }) -- tmux.conf:117
rex.bind("repeat/right", "pane.resize", { amount = 5, direction = "right" }) -- tmux.conf:117

-- ===========================================================================
-- Migrated from Herdr (~/.config/herdr/config.toml), prefix ctrl+a.
-- ===========================================================================
rex.bind("ctrl+a>s", "client.settings") -- config.toml:15
rex.bind("ctrl+a>c", "client.tab.new") -- config.toml:19
rex.bind("ctrl+a>p", "client.tab.previous") -- config.toml:20
rex.bind("ctrl+a>n", "client.tab.next") -- config.toml:21
rex.bind("ctrl+a>1", "client.tab.goto", { index = 1 }) -- config.toml:22
rex.bind("ctrl+a>2", "client.tab.goto", { index = 2 }) -- config.toml:22
rex.bind("ctrl+a>3", "client.tab.goto", { index = 3 }) -- config.toml:22
rex.bind("ctrl+a>4", "client.tab.goto", { index = 4 }) -- config.toml:22
rex.bind("ctrl+a>5", "client.tab.goto", { index = 5 }) -- config.toml:22
rex.bind("ctrl+a>6", "client.tab.goto", { index = 6 }) -- config.toml:22
rex.bind("ctrl+a>7", "client.tab.goto", { index = 7 }) -- config.toml:22
rex.bind("ctrl+a>8", "client.tab.goto", { index = 8 }) -- config.toml:22
rex.bind("ctrl+a>9", "client.tab.goto", { index = 9 }) -- config.toml:22
rex.bind("ctrl+a>shift+x", "client.tab.close") -- config.toml:23
rex.bind("ctrl+a>,", "client.tab.rename") -- config.toml:24
rex.bind("ctrl+a>shift+\\", "pane.split", { direction = "right" }) -- config.toml:28
rex.bind("ctrl+a>shift+'", "pane.split", { direction = "down" }) -- config.toml:29
rex.bind("ctrl+a>x", "pane.close") -- config.toml:30
rex.bind("ctrl+a>z", "pane.zoom") -- config.toml:31
rex.bind("ctrl+a>tab", "pane.focus_next") -- config.toml:36
rex.bind("ctrl+a>shift+tab", "pane.focus_previous") -- config.toml:37

-- Herdr's resize mode. The resize mode and resize/enter are already set up
-- above (cmd+r); this adds escape and Herdr's ctrl+a r entry.
rex.bind("resize/escape", "client.mode.exit")
rex.bind("ctrl+a>r", "client.mode.enter", { name = "resize" }) -- config.toml:40
-- Herdr's resize/left, down, up and right (config.toml:40) are already bound
-- to the same action by the resize loop near the top of this file.

rex.bind("ctrl+a>shift+q", "session.close") -- config.toml:45
rex.bind("ctrl+a>shift+n", "session.new") -- config.toml:46
rex.bind("ctrl+a>shift+w", "session.rename") -- config.toml:47
rex.bind("ctrl+a>shift+o", "session.switch") -- config.toml:48
rex.bind("ctrl+a>space", "session.switch") -- config.toml:49
rex.bind("ctrl+a>shift+9", "session.previous") -- config.toml:50
rex.bind("ctrl+a>shift+0", "session.next") -- config.toml:51

-- ===========================================================================
-- Ghostty (~/.config/ghostty/config): nothing added. Its keys are already
-- bound above (kept by decision) or are Rex defaults.
-- zellij (~/.config/zellij/config.kdl): file not found, nothing migrated.
-- WezTerm (~/.config/wezterm/wezterm.lua): no key bindings, nothing migrated.
-- ===========================================================================

-- ===========================================================================
-- Machine-specific config. On the Canary work Mac, load ~/.config/rex/canary.lua.
-- That file is not in the dotfiles; require looks beside the init.lua symlink.
-- Loaded last so its bindings win over the ones above.
-- ===========================================================================
local hostname = rex.exec({ "scutil", "--get", "LocalHostName" }).stdout:gsub("%s+$", "")
if hostname == "Canary-M9G4L3CV44" then
	require("canary")
end
require("rexdiff")

-- Find File: fzf float that opens the pick beside the focused pane (ctrl+a f).
require("fzf_open")
