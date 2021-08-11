# give us access to ^Q
stty -ixon

# vi mode
bindkey -v

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey "^Q" push-line-or-edit
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

fzf-tmux-project(){
  local cmd="ls -d ~/Code/* ~/Projects/*"
  setopt localoptions pipefail no_aliases 2> /dev/null

  local dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height 100% --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m)"
  if [[ -z "$dir" ]]; then
    return 0
  fi

  n=$(basename $dir)
  session=${n//[[:punct:]]/-}

  if [[ -z "${TMUX}" ]]; then
    tmux new-session -A -s "$session" -c "$p" -n "main"
  else
    tmux new-session -d -s "$session" -c "$p" -n "main"
    tmux switch-client -t "$session"
  fi
  return 0
}

bindkey -s "^P" 'fzf-tmux-project\n'
