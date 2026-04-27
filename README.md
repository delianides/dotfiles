# dotfiles [![Test & Lint Dotfiles](https://github.com/delianides/dotfiles/actions/workflows/dotfiles.yml/badge.svg)](https://github.com/delianides/dotfiles/actions/workflows/dotfiles.yml)

My personal macOS dotfiles, managed with [RCM](https://github.com/thoughtbot/rcm). Sets up a full development environment — shell, editors, terminals, and CLI tools — with a single `./install`.

## Installation

Clone into `~/.dotfiles` and run the installer:

```bash
git clone https://github.com/delianides/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

The installer will:

1. Install Xcode command-line tools (if missing).
2. Install Homebrew, then run `Brewfile`, `Brewfile.casks`, and `Brewfile.mas`.
3. Switch the login shell to `zsh`.
4. Symlink dotfiles into `$HOME` via `rcup`.
5. Apply macOS system defaults from `system/macos`.
6. Install [asdf](https://asdf-vm.com/) language plugins (bun, node, python, ruby, rust, go) and the versions in `.tool-versions`.
7. Install [Claude Code](https://docs.claude.com/claude-code).

After install: remap Caps Lock to Control in System Settings, install tmux plugins with `prefix + I`, and install any non-Homebrew fonts you want manually.

## Usage

RCM commands (these are the day-to-day workflow):

| Command | What it does |
|---|---|
| `rcup -d .` | (Re)link all dotfiles into `$HOME`, respecting `rcrc` |
| `rcdn` | Remove all symlinks |
| `mkrc <file>` | Move a file into the dotfiles repo and replace it with a symlink. Use `-t <tag>` to scope to a tag |
| `lsrc` | Show every dotfile and where it links to |

Shell helpers:

- `qq` or `reload!` — reload the current zsh session.

## Layout

Each `tag-*` directory is an [RCM tag](https://github.com/thoughtbot/rcm). The active tags (`shell editor terminal`, set in `rcrc`) tell `rcup` which directories to link. Files inside are symlinked into `$HOME` with the tag prefix stripped — `tag-shell/zshrc` becomes `~/.zshrc`, `tag-editor/config/nvim/` becomes `~/.config/nvim/`, and so on.

### `tag-shell` — shell, git, and CLI tooling

- **Zsh** — `zshenv`, `zshrc`, `aliases`. Plugins are sourced from Homebrew (no plugin manager).
- **Starship** prompt — config lives under `tag-terminal/config/starship.toml`.
- **Git** — `gitconfig` with [delta](https://github.com/dandavison/delta) as the pager and 1Password SSH commit signing. Conditional includes pick the right identity based on the working directory (`~/Work/`, `~/Github/`, `~/Gitlab/`).
- **asdf** — `asdfrc`, `tool-versions`, `default-*` package lists per language.
- **tmux** — `config/tmux/tmux.conf`, paired with [sesh](https://github.com/joshmedeski/sesh) for session management.
- **Other tools** — `config/direnv/`, `config/zellij/`, `config/worktrunk/`, plus a `bin/` directory of custom scripts.
- **Claude Code** — `claude/` holds settings and hooks.

### `tag-editor` — editors

- **Neovim** — [LazyVim](https://www.lazyvim.org/)-based config in `config/nvim/`. Plugin specs live in `lua/plugins/`, with extras and config split out into `lua/plugins/extras/` and `lua/config/`.
- **Helix** — `config/helix/`.
- **Zed** — `config/zed/` (settings and keybindings).
- **JetBrains IDEs** — `ideavimrc` for IdeaVim.

### `tag-terminal` — terminal emulators and prompt

- **Ghostty** — `config/ghostty/config`.
- **WezTerm** — `config/wezterm/wezterm.lua`.
- **cmux** — `config/cmux/` for the [cmux](https://github.com/cmux-app/cmux) terminal multiplexer.
- **Starship** — `config/starship.toml`.

## Brewfiles

Homebrew installs are split into three files:

- `Brewfile` — taps and CLI formulae (neovim, helix, ripgrep, fzf, gh, lazygit, kubernetes tooling, etc.).
- `Brewfile.casks` — GUI apps (Ghostty, WezTerm, Zed, Raycast, 1Password, Obsidian, Slack, Docker, fonts, …).
- `Brewfile.mas` — Mac App Store apps (installed via [`mas`](https://github.com/mas-cli/mas)).

## CI

`.github/workflows/dotfiles.yml` lints Lua on every push and PR:

- **luacheck** — static analysis for Neovim Lua.
- **StyLua** — formatting check (`stylua --check .`).
