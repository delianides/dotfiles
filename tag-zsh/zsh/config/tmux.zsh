_any_tmux_sessions() {
  [[ -n "$(tmux ls 2>/dev/null)" ]]
}

_most_recent_tmux_session(){
  tmux list-sessions -F "#{session_last_attached} #{session_name}" | \
    sort -r | \
    cut -d' ' -f2 | \
    head -1
}

_not_in_tmux() {
  [[ -z "$TMUX" ]]
}

_tmux_session_exists(){
	local session_name="$1"
	sessions=$(tmux list-sessions | awk -F ':' '{print $1}')
	echo $sessions | grep -q "$session_name"
}

_tmux_orientation() {
  width=$(tmux display -p '#{pane_width}')
  height=$(tmux display -p '#{pane_height}')
  normalized_height=$( echo "$height * 2.2" | bc | xargs printf "%.0f")

  if (( normalized_height > width )); then
    echo 'portrait'
  else
    echo 'landscape'
  fi
}

connect_to_most_recent_tmux_session() {
  if _not_in_tmux && _any_tmux_sessions; then
    tmux attach -t "$(_most_recent_tmux_session)"
  fi
}

tmux-smart-pane() {
  [[ $(_tmux_orientation) = 'portrait' ]] && orient='-v' || orient='-h'
  eval "tmux split-window $orient $@"
}

ensure_tmux_is_running() {
  if _not_in_tmux; then
    tat
  fi
}
