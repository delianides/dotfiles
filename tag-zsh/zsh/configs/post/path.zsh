# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:$PATH"
export GOPATH="$HOME/Code/go"
export GOBIN="$HOME/Code/go/bin"

if [ -d "$HOME/.asdf" ]; then
  # . $HOME/.asdf/asdf.sh
  . /usr/local/opt/asdf/libexec/asdf.sh
fi

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

export -U PATH
