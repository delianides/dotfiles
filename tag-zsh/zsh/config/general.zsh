export GPG_TTY=$(tty)

setopt NO_BG_NICE
setopt NO_HUP                    # don't kill background jobs when the shell exits
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS
setopt PROMPT_SUBST
setopt EXTENDED_GLOB
setopt INC_APPEND_HISTORY
setopt AUTOPUSHD

export VISUAL=nvim
export EDITOR=$VISUAL
export JIRA_EDITOR="$VISUAL -c 'set filetype=jira syntax=yaml'"

export LESS="ij.5nFKMRX"

# Make Zsh's builtin `time` print output like `time` in Bash and every other
# system.
export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

# Note that these FZF options are used by fzf.vim automatically! Yay!
# Use a separate tool to smartly ignore files
export FZF_DEFAULT_COMMAND='rg --hidden --files --ignore-file ~/.ignore'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

in_vs_code(){ [[ "$TERM_PROGRAM" == "vscode" ]] }

inside_ssh(){
  [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]
}

sort-vscode-settings() {
  local f="./Library/Application Support/Code/User/settings.json"
  jq --sort-keys < "$f" | sponge "$f"
}

whois() {
	command whois $(echo "$1" | sed -E -e 's|^https?://||' -e 's|/.*$||g')
}
