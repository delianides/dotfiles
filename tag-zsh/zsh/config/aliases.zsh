alias reload!='RELOAD=1 source ~/.zshrc'
alias qq="cd . && source ~/.zshrc"
alias ls="exa"
alias ll="exa -alh"
alias tree="exa --tree"
alias diff="colordiff -u"

alias gs='git status -sb'

alias mkdir="mkdir -p"
alias cat="bat"
alias rm="trash"
alias tmux="tmux -2"
alias ssh='TERM=xterm-256color ssh'
# alias grep="egrep --color=auto"

alias sed="sed -E" # Use modern regexps for sed, i.e. "(one|two)", not "\(one\|two\)"
alias crontab="VISUAL=vim crontab" # Remove vim flags for crontab -e

alias vi='$VISUAL'
alias vim='$VISUAL'
alias e="$EDITOR"
