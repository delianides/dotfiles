--- @since 25.12.29
--- Jump to the current git repository root, optionally handing off to a search.
---
--- Both `fr` and Yazi's built-in `search` work from the cwd with no way to
--- override it, so to cover a whole repo from a nested directory we cd to the
--- root first and then delegate. Emits are queued in order, so the search sees
--- the new cwd rather than the one we started in.
---
---   plugin repo-root             -- just jump to the repo root
---   plugin repo-root fr rg       -- jump, then grep contents via fr
---   plugin repo-root fr rga      -- jump, then grep PDFs/docs/archives via fr
---   plugin repo-root search fd   -- jump, then search filenames
---   plugin repo-root search rg   -- jump, then search contents

local cwd = ya.sync(function()
  return tostring(cx.active.current.cwd)
end)

local function root_of(dir)
  local output = Command("git")
    :arg({ "-C", dir, "rev-parse", "--show-toplevel" })
    :stdout(Command.PIPED)
    :stderr(Command.NULL)
    :output()

  if not output or not output.status.success then
    return nil
  end

  local root = output.stdout:gsub("%s+$", "")
  return root ~= "" and root or nil
end

return {
  entry = function(_, job)
    local here = cwd()
    local root = root_of(here)
    local tool, via = job.args[1], job.args[2]

    if root and root ~= here then
      ya.emit("cd", { Url(root) })
    elseif not root and not tool then
      -- Only worth complaining about when jumping was the whole point;
      -- a search outside a repo still works fine, just scoped to the cwd.
      return ya.notify {
        title = "repo-root",
        content = "Not inside a git repository",
        timeout = 3,
        level = "warn",
      }
    end

    if tool == "fr" then
      ya.emit("plugin", { "fr", via })
    elseif tool == "search" then
      ya.emit("search", { via = via })
    elseif tool then
      ya.notify {
        title = "repo-root",
        content = string.format("`%s` is not a valid argument. Use `fr` or `search`", tool),
        timeout = 5,
        level = "error",
      }
    end
  end,
}
