# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles managed with [RCM](https://github.com/thoughtbot/rcm) (thoughtbot's dotfile manager). Files are organized into `tag-*` directories that RCM symlinks into `$HOME` as dotfiles.

## Key Commands

- **Full install**: `./install` — installs Homebrew, Brewfile packages, links dotfiles, sets up asdf plugins
- **Link dotfiles**: `rcup -d .` (uses `rcrc` for config — excludes, tags, undotted dirs)
- **Unlink dotfiles**: `rcdn`
- **Add a new dotfile**: `mkrc <file>` (with `-t <tag>` for tag-specific)
- **List linked dotfiles**: `lsrc`
- **Reload shell**: `qq` or `reload!`

## CI

GitHub Actions runs on push/PR (`.github/workflows/dotfiles.yml`):
- **luacheck** — lints Lua files (Neovim config)
- **StyLua** — checks Lua formatting (`stylua --check .`)

When editing Neovim Lua files, ensure they pass both luacheck and StyLua formatting.

## Architecture

### RCM Tag System

Each `tag-*` directory maps to an RCM tag (configured in `rcrc` via `TAGS`). Files inside are symlinked to `$HOME` with the tag prefix stripped:
- `tag-shell/zshrc` → `~/.zshrc`
- `tag-editor/config/nvim/init.lua` → `~/.config/nvim/init.lua`
- `tag-shell/gitconfig` → `~/.gitconfig`

Active tags: `shell editor terminal`

`rcrc` also defines `EXCLUDES` (files that should not be symlinked, like Brewfiles and install scripts) and `UNDOTTED` (dirs symlinked without a leading dot, e.g., `Library`).

### Homebrew

Split across three Brewfiles:
- `Brewfile` — taps and CLI formulae
- `Brewfile.casks` — GUI applications
- `Brewfile.mas` — Mac App Store apps

### tag-shell

Consolidates zsh, git, asdf, and tmux configs:
- `zshenv` — environment variables, Homebrew shell env, PATH setup
- `zshrc` — zsh plugins (sourced from Homebrew), shell options, Starship prompt, sesh/tmux integration
- `aliases` — shell aliases (eza, bat, trash, etc.)
- `bin/` — custom scripts added to PATH
- `gitconfig` — uses delta as pager, 1Password SSH signing for commits, conditional includes for work/personal profiles based on directory (`~/Work/`, `~/Github/`, `~/Gitlab/`)
- `gitignore` — global gitignore
- `asdfrc`, `tool-versions`, `default-*` — asdf version manager config and default packages
- `config/tmux/tmux.conf` — tmux configuration

### tag-editor

Consolidates Neovim, Zed, and IdeaVim configs:
- `config/nvim/` — LazyVim-based Neovim config. Plugin specs in `lua/plugins/`, extras in `lua/plugins/extras/`, config files (keymaps, options, autocmds) in `lua/config/`
- `config/zed/` — Zed editor settings and keybindings
- `ideavimrc` — IdeaVim (JetBrains) config

### tag-terminal

Terminal emulator configs:
- `config/ghostty/config` — Ghostty terminal config
- `config/wezterm/wezterm.lua` — WezTerm terminal config
- `config/starship.toml` — Starship prompt theme
