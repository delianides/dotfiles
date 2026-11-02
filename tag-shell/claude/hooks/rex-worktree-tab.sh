#!/usr/bin/env bash
# Claude Code hook (SessionStart, CwdChanged, SessionEnd): name the Rex tab this
# session runs in after the git worktree it's working in, prefixed with the
# Nerd Font worktree icon (nf-cod-worktree). Leaving the worktree, or ending the
# session, restores the tab's previous name.
#
# Rex is only called when the tab name needs to change, so ordinary directory
# changes cost a couple of git calls.

[ -n "${REX_BLOCK:-}" ] || exit 0
command -v rex >/dev/null 2>&1 || exit 0

input="$(cat)"
event="$(jq -r '.hook_event_name // empty' <<<"$input")"
dir="$(jq -r '.new_cwd // .cwd // empty' <<<"$input")"

# Per Rex pane: the tab's name before we renamed it, and the name we set.
state_dir="${TMPDIR:-/tmp}/claude-rex-tab"
state="$state_dir/${REX_BLOCK//[^A-Za-z0-9_-]/_}"
applied="$state.applied"

rex_() { rex --timeout 2s --autostart=false "$@" 2>/dev/null; }
window() { rex_ block inspect "$REX_BLOCK" --json | jq -r '.block.window_id // empty'; }

restore() {
  [ -f "$state" ] || exit 0
  w="$(window)"
  [ -n "$w" ] && rex_ window rename "$w" "$(cat "$state")" >/dev/null
  rm -f "$state" "$applied"
  exit 0
}

[ "$event" = "SessionEnd" ] && restore
[ -n "$dir" ] || exit 0

git_dir="$(git -C "$dir" rev-parse --path-format=absolute --git-dir 2>/dev/null)" || restore
common_dir="$(git -C "$dir" rev-parse --path-format=absolute --git-common-dir 2>/dev/null)" || restore
# Main checkout, not a linked worktree.
[ "$git_dir" != "$common_dir" ] || restore

name="$(basename "$(git -C "$dir" rev-parse --show-toplevel)")"
icon=$'\xee\xb1\xbe' # U+EC7E nf-cod-worktree
label="$icon $name"

# Already named for this worktree (e.g. a cd within it).
[ "$(cat "$applied" 2>/dev/null)" = "$label" ] && exit 0

w="$(window)"
[ -n "$w" ] || exit 0

if [ ! -f "$state" ]; then
  current="$(rex_ window inspect "$w" --json | jq -r '.label // empty')"
  # Don't save one of our own labels as the original.
  if [ -n "$current" ] && [ "${current#"$icon "}" = "$current" ]; then
    mkdir -p "$state_dir" && printf '%s' "$current" >"$state"
  fi
fi

rex_ window rename "$w" "$label" >/dev/null && mkdir -p "$state_dir" && printf '%s' "$label" >"$applied"
exit 0
