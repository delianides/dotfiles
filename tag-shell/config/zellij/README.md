# zellij

Config for [Zellij](https://zellij.dev/), set up to feel as close to tmux as possible. Symlinked to `~/.config/zellij/` via RCM.

- **Default mode:** `locked` — most keys pass straight through to the running program (nvim, etc.). Modes are entered explicitly through the tmux prefix.
- **Prefix:** `Ctrl-a`, mirroring tmux. Pressing it from any non-tmux mode enters tmux mode.
- **Theme:** `rose-pine-moon`. Custom themes live in `themes/`, layouts in `layouts/`.

## Mode switching

| Key | Mode |
|---|---|
| `Ctrl-a` | Enter tmux mode (from anywhere except tmux mode itself) |
| `Ctrl-n` | (from locked) Enter normal mode |
| `Esc` | Back to locked (from any mode except locked) |
| `Ctrl-q` | Quit Zellij |

From **tmux mode** (i.e. after `Ctrl-a`) you can hop to other modes:

| Key | Mode |
|---|---|
| `s` | Session |
| `[` | Scroll / copy |
| `r` | Resize |
| `P` | Pane |
| `m` | Move |
| `t` | Tab |
| `g` | Locked |

## Pane nav (works in any mode — `shared`)

| Key | Action |
|---|---|
| `Ctrl-h/j/k/l` | Smart pane nav via [vim-zellij-navigator](https://github.com/hiasr/vim-zellij-navigator) — forwards to Neovim when focused, otherwise moves Zellij focus. `h`/`l` also wrap to the previous/next tab |

## Tmux mode (after `Ctrl-a`)

Behaves like a tmux prefix release. Each command drops back to locked mode.

| Key | Action |
|---|---|
| `Ctrl-a` | Send literal `Ctrl-a` to the pane |
| `-` | New pane to the right |
| `_` | New pane below |
| `o` | New stacked pane |
| `c` | New tab |
| `,` | Rename tab |
| `p` / `n` | Previous / next tab |
| `x` | Close focused pane |
| `z` | Toggle fullscreen |
| `w` | Toggle floating panes |
| `e` | Toggle pane embed/floating |
| `Space` | Cycle layout |
| `d` | Detach session |

## Pane mode (`Ctrl-a P`)

| Key | Action |
|---|---|
| `h/j/k/l` or arrows | Move focus |
| `p` | Cycle focus |
| `n` | New pane |
| `d` / `r` | New pane down / right |
| `x` | Close focused pane |
| `f` | Toggle fullscreen |
| `z` | Toggle pane frames |
| `w` | Toggle floating |
| `e` | Toggle embed/floating |
| `c` | Rename pane |

## Tab mode (`Ctrl-a t`)

| Key | Action |
|---|---|
| `h/k/Left/Up` | Previous tab |
| `l/j/Right/Down` | Next tab |
| `n` | New tab |
| `x` | Close tab |
| `r` | Rename tab |
| `s` | Toggle sync-input across tab |
| `b` / `[` / `]` | Break pane to new tab / left / right |
| `1`–`9` | Jump to tab N |
| `Tab` | Toggle to last tab |

## Resize mode (`Ctrl-a r`)

| Key | Action |
|---|---|
| `h/j/k/l` or arrows | Increase in that direction |
| `H/J/K/L` | Decrease in that direction |
| `=` / `+` | Increase |
| `-` | Decrease |

## Move mode (`Ctrl-a m`)

| Key | Action |
|---|---|
| `n` / `Tab` | Move pane forward |
| `p` | Move pane backward |
| `h/j/k/l` | Move pane in that direction |

## Scroll / search mode (`Ctrl-a [`)

| Key | Action |
|---|---|
| `j/k` or arrows | Line up / down |
| `Ctrl-f` / `Ctrl-b` | Page down / up |
| `d` / `u` | Half page down / up |
| `s` | Start a search |
| `e` | Edit scrollback in `$EDITOR` |
| `Ctrl-c` | Jump to bottom and exit |

In search: `n` / `p` next/previous match, `c` toggle case sensitivity, `w` wrap, `o` whole word.

## Session mode (`Ctrl-a s`)

| Key | Action |
|---|---|
| `d` | Detach |
| `w` | Open the session-manager plugin (floating) |

## Notable settings

- `default_mode "locked"` — keystrokes pass through unless you explicitly enter a mode.
- `session_serialization false` — sessions aren't persisted across restarts.
- `scroll_buffer_size 50000`.
- `default_layout "default"` (see `layouts/`).
