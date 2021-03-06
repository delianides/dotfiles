dotfiles ![Dotfiles](https://github.com/delianides/dotfiles/workflows/Dotfiles/badge.svg)
========

Welcome to my dotfiles! The files here are a pretty minimal setup for easily running Docker, Tmux, and Vim. I'm currently using [RCM](https://github.com/thoughtbot/rcm) from thoughtbot to manage everything.

Installation
------------

```
$ ./install
```
This script installs the following:
- Homebrew with applications defined in the `Brewfile`
  - Tmux
  - Vim/Neovim
  - Alcritty
  - ...lots more
- Also runs `.macos` which sets up plist configurations for MacOS

Usage
-----

Reposting usage instructions here:

- `rcup` is the main program. It is used to install and update dotfiles,
  with support for tags, host-specific files, and multiple source
  directories.
- `rcdn` is the opposite of `rcup`.
- `mkrc` is for introducing a dotfile into your dotfiles directory, with
  support for tags and multiple source directories.
- `lsrc` shows you all your dotfiles and where they would be symlinked
  to. It is used by `rcup` but is provided for your own use, too.

Inspiration
-----------

- [Zach Holman](https://github.com/holman/dotfiles)
- [Mike Hartington](https://github.com/mhartington/dotfiles)
- [Nick Nisi](https://github.com/nicknisi/dotfiles)
- [Chris Toomey](https://github.com/christoomey/dotfiles)
- [Gabe Berke-Williams](https://github.com/gabebw/dotfiles)
- [Greg Hurrell](https://github.com/wincent/wincent)
- [Ahmed El Gabri](https://github.com/ahmedelgabri/dotfiles)
- [Junegunn Choi](https://github.com/junegunn/dotfiles)
- [TJ DeVries](https://github.com/tjdevries/config_manager)
