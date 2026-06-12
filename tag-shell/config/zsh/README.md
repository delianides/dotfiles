# zsh

The shell setup. Files are spread across a few locations because zsh and RCM both have opinions about layout:

| Source (in repo) | Symlink target | Purpose |
|---|---|---|
| `tag-shell/zshenv` | `~/.zshenv` | Loaded for every shell — env vars, PATH, Homebrew shellenv |
| `tag-shell/zshrc` | `~/.zshrc` | Interactive shells — plugins, completion, prompt, keybindings |
| `tag-shell/aliases` | `~/.aliases` | Sourced from `~/.zshrc` |
| `tag-shell/config/zsh/git.plugin.zsh` | `~/.config/zsh/git.plugin.zsh` | Git aliases + helpers, ported from oh-my-zsh |

There is no plugin manager — every plugin is a Homebrew package and is `source`d directly from `$(brew --prefix)`. Init evals (fzf, direnv, starship, zoxide, brew shellenv) are cached under `~/.cache/zsh-evals/` and only re-run when the underlying binary is newer than the cache, which keeps shell startup fast. To force a refresh: `rm -rf ~/.cache/zsh-evals`.

## Plugins (in load order)

1. **fzf-tab** — fzf-powered tab completion (loaded after `compinit`).
2. **fzf** — `Ctrl-R` history search, `Ctrl-T` file picker (`rg --hidden --files`), `Alt-C` cd.
3. **zsh-vi-mode** — vi keybindings; `jj` exits insert mode. Re-applies fzf bindings after init so `Ctrl-R` survives.
4. **zsh-autosuggestions** — fish-style ghost-text suggestions, max 20 chars.
5. **zsh-syntax-highlighting** — must load near end.
6. **zsh-history-substring-search** — must load after syntax highlighting.

## Prompt and tools

- **Starship** — prompt, themed via `tag-terminal/config/starship.toml`.
- **zoxide** — replaces `cd`. Skipped under Claude Code (`$CLAUDECODE == 1`).
- **direnv** — auto-loads `.envrc` per directory.
- **vivid** — generates `LS_COLORS` once, cached at `~/.cache/ls_colors`. To regenerate: `vivid generate molokai > ~/.cache/ls_colors`.
- **worktrunk** — `wt config shell init zsh` is sourced for shell helpers.
- **macos-trash** — `rm` is aliased to `trash`.

## Keybindings

| Key | Action |
|---|---|
| `Ctrl-R` | fzf history search |
| `Ctrl-T` | fzf file picker |
| `Alt-C` | fzf cd |
| `Ctrl-O` | sesh session switcher (in supported terminals) |
| `jj` | Exit insert mode (vi-mode) |
| `↑` / `↓` | History substring search (after typing a prefix) |

## Aliases (highlights)

| Alias | Expands to |
|---|---|
| `qq` | `cd . && source ~/.zshrc` (fast reload) |
| `reload!` | `RELOAD=1 source ~/.zshrc` |
| `ls` / `ll` / `l` / `tree` | [eza](https://eza.rocks/) variants |
| `cat` | [bat](https://github.com/sharkdp/bat) |
| `rm` | `trash` (macos-trash) |
| `vi` / `vim` | `$VISUAL` (nvim) |
| `pn` | `pnpm` |
| `k` | `kubectl --kubeconfig ~/.kubeconfig-integrations-developer` |
| `..` … `.....` | Walk up 1–4 dirs |

The full list is in `tag-shell/aliases`. Git aliases come from `git.plugin.zsh` (e.g. `gst`, `gco`, `gcm`, `gp`, `gpf!`, `glog`).

## Shell options

History is shared across sessions and dedup'd:

```
APPEND_HISTORY EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS
HIST_IGNORE_SPACE HIST_VERIFY INC_APPEND_HISTORY SHARE_HISTORY
```

Other notable options: `EXTENDED_GLOB`, `AUTOPUSHD`, `PROMPT_SUBST`, `NO_BG_NICE`, `NO_HUP`, `NO_LIST_BEEP`. `AUTO_CD` is **off** — bare directory names won't `cd` for you (that's what zoxide is for).

## Environment

`zshenv` sets:

- `LANG`/`LC_ALL`/`LC_CTYPE` to `en_US.UTF-8`.
- `HOMEBREW_NO_AUTO_UPDATE=1` and friends — Homebrew won't auto-update on every install.
- `FZF_DEFAULT_COMMAND='rg --hidden --files --ignore-file ~/.ignore'`.
- `WORKTRUNK_PROJECT_CONFIG_PATH='.local/wt.toml'`.
- `PATH` prepends: `$HOME/.local/bin`, `$HOME/.bin`, `$HOME/.lmstudio/bin`, then `brew shellenv`.

`zshrc` exports:

- `VISUAL=nvim`
- `MANPAGER='bat --plain'`

## `~/.localrc`

If `~/.localrc` exists it is sourced near the end of `~/.zshrc` — use it for machine-specific or sensitive settings that shouldn't live in the repo.
