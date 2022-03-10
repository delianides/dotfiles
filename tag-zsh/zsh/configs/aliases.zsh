alias e=$EDITOR
# youtube-dl
alias yt='youtube-dl --output "$PWD/%(extractor_key)s/%(uploader)s [%(channel_id)s]/%(title)s [%(id)s].%(ext)s"'
alias ytp='youtube-dl --output "$PWD/%(extractor_key)s/%(uploader)s [%(channel_id)s]/%(playlist)s/%(playlist_index)s - %(title)s [%(id)s].%(ext)s"'
alias audio='youtube-dl --ignore-config -f bestaudio --extract-audio --audio-format mp3 --embed-thumbnail --add-metadata --audio-quality 0 --output "$PWD/%(uploader)s - %(title)s.%(ext)s"'

function ytinfo() {
  youtube-dl --ignore-config --dump-json $1 | jq
}

# alias npm="NEWT_SKIP_VPNCHECK=1 newt exec npm"
alias vim="nvim"
alias vi="nvim"
alias qq="cd . && source ~/.zshrc"
alias ls="exa"
alias rm="trash"
alias aci="asciinema"

alias re-source="source ~/.localrc"
alias tmux="tmux -2"
alias ssh='TERM=xterm-256color ssh'
alias grep="egrep --color=auto"

# Copy-pasting `$ python something.py` works
alias \$=''
alias diff="colordiff -u"
alias mkdir="mkdir -p"

# Global aliases
alias -g G="| grep "
alias -g ONE="| awk '{ print \$1}'"

