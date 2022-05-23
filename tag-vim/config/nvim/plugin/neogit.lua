  local ok, neogit = pcall(require, "neogit")
  if not ok then
    return
  end

  neogit.setup {
    disable_signs = true,
    kind = "split",
    commit_popup = {
      kind = "split",
    },
    integrations = {
      diffview = true,
    },
    disable_builtin_notifications = true,
  }

