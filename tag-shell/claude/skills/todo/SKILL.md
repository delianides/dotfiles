---
name: todo
description: Use when the user wants something added to their Tweek planner — "/todo", "add a todo", "add this to tweek", "put X on my list for Friday". Accepts an optional `--date`, `--color` and `--note`; all have defaults, so the task text alone is enough.
---

# Add a todo to Tweek

Arguments: `/todo <text> [--date <when>] [--color <color>] [--note <text>] [--refresh]`

- `text` — the task title. The only required part.
- `--date` — when it lands. **Default: today.**
- `--color` — the task colour. **Default: no colour.**
- `--note` — free-text detail under the title. Default: none.
- `--refresh` — re-read the calendar, lists and colours from Tweek before adding.

Never ask the user for a date or a colour. A missing one takes its default.

## Dates and colours written into the sentence

The flags can be replaced by plain words at the **end** of the text:
`/todo call the dentist tomorrow in green` is `call the dentist`, tomorrow, green.

- Only a trailing date or colour phrase is lifted out, along with the `in` / `on` / `by` /
  `for` that introduces it. The same word anywhere else is part of the title:
  `watch Friday Night Lights` and `buy pink ribbon` keep every word.
- A trailing word that reads as the object of the sentence stays too: `paint the fence
  green` is a title, `paint the fence in green` is a green task.
- A flag beats a word in the sentence. With `--date` given, date words stay in the title;
  likewise `--color`.
- `someday` and `later` only mean the Someday list as a `--date` value or as the final
  word. `call mom later today` is dated today.
- What is left is the title, exactly as written. Do not rephrase, expand, or punctuate it.

## 1. Load the tools

The Tweek tools are deferred. Load them in one call:

```
ToolSearch  select:mcp__tweek__list_calendars,mcp__tweek__list_colors,mcp__tweek__create_task,mcp__tweek__bulk_create_tasks
```

If they do not resolve, the `tweek` MCP server is not connected. Say so and stop — the
user reconnects it with `/mcp`.

## 2. Find the calendar

The calendar, its someday-lists and the colour palette rarely change, so they are cached
in `${XDG_CACHE_HOME:-$HOME/.cache}/todo-skill/tweek.json`:

```json
{
  "calendarId": "…",
  "lists": [{ "id": "…", "name": "Someday" }],
  "colors": [{ "id": "…", "backgroundColor": "#66EBFF" }]
}
```

Read that file first. When it exists and parses, use it and make no lookup calls.

When it is missing or unreadable, build it: `list_calendars` and `list_colors`, take the
calendar with `isDefault: true` (the first one if several are), and write the file with
that calendar's `id`, its `lists`, and the colours.

Rebuild it the same way, then carry on, when:

- the user passes `--refresh`;
- the date is `someday` and the cache has no list named `Someday`;
- a colour is asked for that nothing in the cached palette matches;
- `create_task` or `bulk_create_tasks` rejects the calendar, list or colour id. Retry the
  create once with the fresh values.

## 3. Resolve the date

Get dates from the shell, not from memory — the session's idea of "today" goes stale.
These are macOS `date` forms, in the machine's local timezone:

| The user says | Placement |
|---|---|
| nothing | `date` = `date +%F` |
| `today`, `tomorrow` | `date +%F`, `date -v+1d +%F` |
| a weekday (`friday`, `this friday`, `next monday`) | the coming one: `date -v+fri +%F`, or `date -v+fri -v+1w +%F` when that prints today |
| `in 3 days`, `in 2 weeks`, `next week`, `next month` | `date -v+3d +%F`, `-v+2w`, `-v+1w`, `-v+1m` |
| an explicit date (`2026-10-14`, `Oct 14`, `10/14`) | that day as `YYYY-MM-DD`. Slashed dates are month/day. With no year, use this year, or next year when the day is before today |
| `someday`, `later`, `no date` | `listId` of the list named `Someday`, and no `date` |

`next monday` is the coming Monday, the same as `monday`.

Set exactly one of `date` or `listId`. A task with neither is created but invisible, so if
there is no list named `Someday`, date the task today and say that is what happened.

A time of day (`at 3pm`) stays in the title; this skill sets no reminders.

## 4. Resolve the colour

| The user says | `color` |
|---|---|
| nothing, `none`, `blank` | omit the field |
| `pink` | `pink` |
| `yellow` | `yellowish` |
| anything else (`blue`, `green`, a hex code) | the id in the cached `colors` whose `backgroundColor` a person would call by that name |

A near match counts: `blue` takes a cyan or sky-blue swatch, `green` takes a lime one. When
nothing in the palette would be called by that name — still nothing after the rebuild in
step 2 — create the task with no colour and
say so, listing what is available (`pink`, `yellow`, and each custom colour by its hex).
Never substitute an unrelated colour. The colour word still leaves the title.

## 5. Create

One task: `create_task` with `calendarId`, `text`, the placement, and `color` / `note` when
set.

Several tasks in one request (items separated by `;` or on separate lines):
`bulk_create_tasks`, at most 50 per call, each item carrying its own `calendarId`, `text`
and placement. Flags apply to every item, wherever they appear. A date or colour written
into one item's own text applies to that item only.

Check `failed` in the result and report each failure with its reason.

## 6. Report

One line per task — the title, where it landed (`date -j -f %F <date> "+%a %-d %b"`, plus
the year when it is not this year), and the colour as the user named it:

```
Added "call the dentist" — Sat 3 Oct, green
Added "email Sam" — Tue 5 Jan 2027
Added "read the OHIP migration doc" — Someday
Added "paint the fence" — Fri 2 Oct, no colour (no purple; you have pink, yellow, #66EBFF, #1EDC00)
```

## Out of scope

Editing, completing, moving, or deleting existing tasks; recurring tasks, reminders, and
subtasks (Tweek premium). Use the Tweek tools directly for those.
