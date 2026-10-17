---
name: agent-to-workspace
description: Give the running `claude agents` background session its own cmux workspace — a new workspace named after the agent's ticket or Claude's session name, opened on its worktree, with the agent attached in it. Use for "/agent-to-workspace", "move this agent to its own workspace", "give this agent a workspace", "pop this agent out into cmux". Accepts an optional workspace name and `--window <id|ref|index>`.
---

# Give this agent its own cmux workspace

Arguments: `/agent-to-workspace [name] [--window <id|ref|index>]`

- `name` — use this as the workspace title instead of deriving one from the branch.
- `--window` — create the workspace in that window. Omitted, it goes in the window you are
  looking at.

This is for **`claude agents` background sessions**. Nothing is moved or restarted: the
agent keeps running exactly where it is, and the new workspace is just a terminal attached
to it. Close that pane and the agent carries on — you only detached.

Export `CMUX_QUIET=1` before the first `cmux` call; legacy aliases otherwise print a
deprecation notice to stdout that corrupts parsing.

## 0. Parse the arguments

`--window <value>` (or `--window=<value>`) sets `WINDOW_ARG`. Any other argument is the
`NAME` override — if there are several words, join them with spaces. Neither is required.

## 1. Confirm this is a background agent

```bash
ROW=$(claude agents --json 2>/dev/null \
  | jq -c --arg sid "${CLAUDE_CODE_SESSION_ID:-}" '.[] | select(.sessionId == $sid)')
KIND=$(printf '%s' "$ROW" | jq -r '.kind // empty')
AGENT_ID=$(printf '%s' "$ROW" | jq -r '.id // empty')
AGENT_NAME=$(printf '%s' "$ROW" | jq -r '.name // empty')
```

`AGENT_NAME` is the name Claude gave the session — the one `claude agents` lists. Step 3
uses it as the fallback title.

Stop, and make no cmux writes, if any of these hold:

- `$CLAUDE_CODE_SESSION_ID` is empty — this is not running inside Claude Code.
- No row matched, or `KIND` is not `background` — this is a standalone session. Say so:
  *"/agent-to-workspace is for `claude agents` background sessions. This session lives in
  its own terminal, so there is nothing to attach to."*
- `AGENT_ID` is empty — `claude attach` takes the short id, and without it there is
  nothing to launch.

Match on `sessionId`, never on `id`: not every row in `claude agents --json` has a short
`id`, and a filter that assumes one breaks on the first row that doesn't.

**Why `attach` and not `--resume`.** `claude attach <id>` opens the *same running
process* in a new terminal — mid-turn work keeps going, nothing is copied. `claude --resume
<id>` would start a new process from the saved transcript, and on a session that is still
running that makes a *second copy*: two diverging agents working in the same worktree.

## 2. Read the git context

From this session's own working directory — not the `cwd` in `claude agents --json`, which
is where the agent was *launched*. An agent that has since entered a worktree is working
somewhere else.

```bash
ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
WORKTREE=
if [ -n "$ROOT" ] && [ "$(git rev-parse --path-format=absolute --git-dir)" \
     != "$(git rev-parse --path-format=absolute --git-common-dir)" ]; then
  WORKTREE="$ROOT"
fi
CWD="${ROOT:-$PWD}"
```

**`--path-format=absolute` is load-bearing.** Without it, `--git-common-dir` comes back
relative (`../.git`) when run from a subdirectory while `--git-dir` comes back absolute, so
the main working tree compares unequal and is misreported as a linked worktree.

## 3. Pick the title

First hit wins:

1. `NAME`, verbatim.
2. A ticket ID at the start of the branch or of a path segment in it:

   ```bash
   TICKET=$(printf '%s' "$BRANCH" \
     | grep -oiE '(^|/)[a-z]{2,6}-[0-9]{1,6}(-|$)' | head -1 \
     | sed -E 's#^/##; s#-$##' | tr '[:lower:]' '[:upper:]')
   ```

   `drew/pms-10280-write-check-out` → `PMS-10280`. The anchoring matters: the looser
   `[a-z]+-[0-9]+` turns `cmux-sidebar-1780003356-bddad469` into `SIDEBAR-1780003356`. It
   still reads `drew/utf-8-fix` as `UTF-8` — a real ticket prefix and a word followed by a
   number are indistinguishable by shape, which is what the `name` argument is for.
3. `AGENT_NAME`, verbatim — Claude's auto-generated session name, so the workspace and
   `claude agents` call the agent the same thing.
4. The branch's last path segment, `${BRANCH##*/}` — unless the branch is `main`,
   `master`, `HEAD` (detached), or empty. Only reached if the row has no name.
5. Otherwise stop and ask to re-run with a name: *"No ticket, session name, or feature
   branch to name this workspace after — run `/agent-to-workspace <name>`."* Do not
   invent one.

A ticket-ID title is deliberate: it is the same convention `/ticket` uses, so every
`/ticket:*` skill (`open-linear`, `open-pr`, `refresh`, `mark`) resolves the ticket from
the new workspace with no argument.

## 4. Refuse a duplicate title

Titles are the handle other tooling resolves on, so two workspaces with the same one is a
bug waiting to happen. Check **every** window — `workspace list` is scoped to one:

```bash
for W in $(cmux --json list-windows | jq -r '.[].id'); do
  cmux --json workspace list --window "$W" | jq -r --arg t "$TITLE" --arg w "$W" \
    '.workspaces[] | select((.custom_title // "") == $t) | [.ref, $w] | @tsv'
done
```

Guard the null: an untitled workspace has `custom_title: null`, and handing null to a
string comparison or `test()` in jq aborts the whole program on that row instead of
skipping it.

If anything comes back, stop and report where it is — *"A workspace titled `PMS-10280`
already exists (workspace:12 in window FC874E03…)"* — rather than creating a second one.
Report only the title and location. Do not say which agent it is attached to: it may belong
to a different agent working the same ticket, and nothing here checks.
Test the output, not the exit status: a failing `cmux` or `jq` also prints nothing and
exits 0.

## 5. Resolve the target window

```bash
FOCUSED_WINDOW=$(cmux --id-format uuids identify --json | jq -r '.focused.window_id // empty')
TARGET_WINDOW="${WINDOW_ARG:-$FOCUSED_WINDOW}"
```

A background agent has **no cmux caller**: `identify`'s `.caller` is null and
`CMUX_WORKSPACE_ID` / `CMUX_SURFACE_ID` are unset, because the agent is not running in any
pane. So "the window it's called from" means the window you are looking at when you invoke
this — `.focused`. Resolve it explicitly rather than letting `workspace create` default, so
the report can say where the workspace went.

If both are empty, stop: cmux is not reachable from this session.

## 6. Create the workspace, attached

```bash
WS=$(cmux workspace create --name "$TITLE" --cwd "$CWD" --window "$TARGET_WINDOW" \
  --command "CMUX_CLAUDE_HOOKS_DISABLED=1 claude attach $AGENT_ID" \
  --focus false | sed -n 's/^OK //p' | cut -d' ' -f1)
```

`workspace create` prints `OK workspace:N` — plain text, not JSON, even with `--json`.
Extract the ref with `sed` and `cut`, **not** an awk field reference. Before the model
reads a skill, Claude Code replaces every dollar sign followed by a digit with the matching
invocation argument — so awk's second-field reference silently became the `--window` value
in testing. Keep dollar-digit sequences out of this file entirely, prose included.

`create` prints only the short ref, even with `--id-format uuids`. Resolve it to the
workspace's UUID straight away:

```bash
WS_ID=$(cmux --id-format uuids --json workspace list --window "$TARGET_WINDOW" \
  | jq -r --arg r "$WS" '.workspaces[] | select(.ref == $r) | .id')
```

**Every later call targets `WS_ID`, never `WS`.** Passing `workspace:N` together with
`--window <uuid>` fails with `Workspace ref not found` whenever the target window is not
the focused one: short refs are resolved against the focused window, not against the
`--window` given. The UUID is unambiguous in any window. Keep `--window "$TARGET_WINDOW"`
on those calls too, and never rely on `CMUX_WORKSPACE_ID` defaults here; this session
doesn't have one.

If `WS` or `WS_ID` comes back empty, stop and report the create failure. If only `WS_ID`
is empty, the workspace exists — say so and give its ref so it can be closed by hand.

Three things in that command, each learned the hard way:

- **`CMUX_CLAUDE_HOOKS_DISABLED=1` is required.** Inside a cmux pane, `claude` is cmux's
  wrapper, which injects `--session-id` into every launch except a fixed list of
  subcommands (`agents`, `auth`, `config`, `doctor`, `mcp`, `plugin`, `update`, …).
  `attach` is not on that list, so a bare `claude attach <id>` starts a **brand-new
  session** with `attach <id>` as its first message. The variable sends the call through
  the wrapper untouched. Attach needs no cmux hooks — the agent process has its own.
- **`--cwd` is the agent's worktree or repo root**, so the sidebar shows the right branch
  and a shell opened there lands in the right tree. `attach` itself does not run the
  folder-trust check — verified attaching in an untrusted folder with no prompt. The trust
  dialog only appears when the wrapper bug above turns `attach` into a fresh session.
- **`--focus false`**, then focus deliberately in step 8.

## 7. Describe it

```bash
DESC="$BRANCH${WORKTREE:+ · $WORKTREE}"
cmux workspace-action --action set-description --workspace "$WS_ID" \
  --window "$TARGET_WINDOW" --description "$DESC"
```

Skip this outside a git repo, where there is no branch to describe. A failure here is
cosmetic: report it, keep the workspace.

## 8. Focus, then report

Switch to the new workspace only when it landed in the window you are looking at:

```bash
[ "$TARGET_WINDOW" = "$FOCUSED_WINDOW" ] && \
  cmux workspace select "$WS_ID" --window "$TARGET_WINDOW"
```

With `--window` pointing elsewhere, leave focus alone — yanking you into another window
is not what asking for "that window" means.

Report in a few lines: the workspace ref and title, the window, the agent id it is
attached to, and the branch and worktree it opened on. Close with the one thing people get
wrong: **closing that pane detaches; it does not stop the agent** — use `claude stop
<id>` for that.

## Out of scope

- **Standalone sessions** (step 1 refuses them). Moving one would mean exiting it and
  resuming in the new pane, with a worktree-removal prompt on the way out.
- **Creating, moving, or removing worktrees or branches.** This reports the git context it
  finds and changes none of it.
- **Colors and status pills.** Run `/ticket:refresh` in the new workspace if it is a ticket.
