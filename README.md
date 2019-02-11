dotfiles
========

Welcome to my dotfiles! The files here are a pretty minimal setup for easily running Docker, Tmux, and Vim. I'm currently using [RCM](https://github.com/thoughtbot/rcm) from thoughtbot to manage everything.

Installation
------------

Install Xcode or the command line tools so the required libraries are available during compilation.

```
$ git clone https://github.com/delianides/dotfiles
$ brew bundle dotfiles/Brewfile
$ rcup -d dotfiles -x README.md -x LICENSE -x Brewfile
```

Tmux is configured for italics. Strange things might happen if you don't run:

```
$ tic -x tmux-256color.terminfo
$ tic -x xterm-256color-italic.terminfo
```

Make sure italics are enabled for iTerm and you're using a font that supports
them. (Fira, Dank Mono);


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

