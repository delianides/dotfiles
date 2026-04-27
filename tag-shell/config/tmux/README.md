# tmux

Config for [tmux](https://github.com/tmux/tmux). Symlinked to `~/.config/tmux/tmux.conf` via RCM.

**Prefix:** `Ctrl-a` (rebound from the default `Ctrl-b`).

Plugins are managed by [TPM](https://github.com/tmux-plugins/tpm), auto-installed on first run. Status bar uses [Catppuccin](https://github.com/catppuccin/tmux) (mocha).

## Essentials

| Key | Action |
|---|---|
| `prefix R` | Reload `tmux.conf` |
| `prefix I` | Install plugins (TPM) |
| `prefix U` | Update plugins (TPM) |
| `prefix Q` | Kill the current session |
| `prefix x` | Kill the current pane (no prompt) |

## Sessions ([sesh](https://github.com/joshmedeski/sesh))

| Key | Action |
|---|---|
| `prefix O` | Open the sesh switcher (fzf-tmux popup with previews) |
| `prefix Z` | Open sesh in a popup with `zf` |
| `prefix L` | Jump to the last session |
| `prefix 9` | Connect to the root of `$(pwd)` |

Inside the `prefix O` switcher: `^a` all, `^t` tmux only, `^g` configs, `^x` zoxide dirs, `^f` find, `^d` kill the highlighted tmux session.

## Windows

| Key | Action |
|---|---|
| `prefix c` | New window in the current pane's path |
| `prefix A` | New window running `ai` |
| `prefix b` | New window running `build` |
| `prefix D` | New window running `dev` |
| `prefix E` | New window running `nvim +GoToFile` |
| `prefix g` | New window running `lazygit` |
| `prefix G` | New window running `raycast-git-commit.sh` |
| `prefix Y` | Split + run an `npm run` script (fzf over `package.json`) |
| `prefix B` | Break the current pane into a new window |
| `prefix J` | Join pane to window 1 |

## Panes

| Key | Action |
|---|---|
| `prefix \|` / `prefix %` | Vertical split (current path) |
| `prefix _` / `prefix "` | Horizontal split (current path) |
| `prefix h/j/k/l` | Move focus left/down/up/right |
| `prefix ←/↓/↑/→` | Resize pane by 5 (repeatable) |
| `Ctrl-h/j/k/l` | Smart pane nav — forwards to Neovim when nvim is focused, otherwise moves tmux pane (uses [smart-splits.nvim](https://github.com/mrjones2014/smart-splits.nvim)) |
| `Alt-h/j/k/l` | Smart pane resize (3 cells), nvim-aware |
| `Ctrl-\` | Toggle to last pane (or forwarded to nvim) |

## Copy mode + utilities

| Key | Action |
|---|---|
| `prefix [` | Enter copy mode |
| `v` (in copy mode) | Begin selection |
| `prefix e` | Capture pane scrollback into a new nvim buffer |
| `prefix C` | [tmux-thumbs](https://github.com/fcsonline/tmux-thumbs) — pick anything on screen and copy to clipboard |
| `prefix u` | [tmux-fzf-url](https://github.com/wfxr/tmux-fzf-url) — open a URL from scrollback |
| `prefix H` | [tmux-floax](https://github.com/omerxx/tmux-floax) floating scratch pane |

## Notable settings

- `base-index 1` — windows start at 1.
- `detach-on-destroy off` — closing the last session doesn't kill tmux.
- `escape-time 0` — instant escape (matters in nvim).
- `history-limit 1000000` and `mouse on`.
- `renumber-windows on` — windows renumber when one closes.
- Status bar on top; clock format `H:MM`.

## Plugins

`tpm`, `tmux-sensible`, `tmux-yank`, `tmux-thumbs`, `tmux-fzf`, `tmux-fzf-url`, `tmux-floax`, `tmux-nerd-font-window-name`, `tmux-battery`, `tmux-cpu`, `tmux-resurrect`, `tmux-continuum`, `tmux-logging`, `tmux-better-mouse-mode`, `catppuccin/tmux`.
