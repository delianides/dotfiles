clone(){
  if [[ $# < 2 ]]; then
    echo "Please provide a directory and a repo name" >&2
    echo "Usage: clone personal gabebw/dotfiles [gabebw-dotfiles]" >&2
    return 1
  fi
  local directory=$1
  local session_name
  pushd "$directory" >/dev/null
  shift
  if gcl "$@"; then
    # Name the session after the current directory
    session_name=$(basename "$PWD")
    if tmux-session-exists "$session_name"; then
      session_name="${session_name}-new"
    fi
    tcd "$PWD" "$session_name"
    popd >/dev/null
  fi
  popd >/dev/null
}

new-project(){
  if [[ $# == 0 ]]; then
    printf "Project name? "
    read project_name
  else
    project_name=$1
  fi
  local project_name=${project_name// /-}
  pushd personal >/dev/null
  if [[ -d "$project_name" ]]; then
    echo "!! Project directory with that name already exists" >&2
    return 1
  fi
  if [[ -f "$project_name" ]]; then
    echo "!! Project FILE with that name already exists" >&2
    return 1
  fi
  mkdir "$project_name" && tcd "./$project_name"
  popd >/dev/null
}
