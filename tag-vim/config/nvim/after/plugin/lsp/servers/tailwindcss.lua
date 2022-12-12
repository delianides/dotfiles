local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

lspconfig.tailwindcss.setup {
  root_dir = function(fname)
    return lspconfig.util.root_pattern("tailwind.config.*")(fname)
        -- or lspconfig.util.find_package_json_ancestor(fname)
        -- or lspconfig.util.find_node_modules_ancestor(fname)
        -- or lspconfig.util.find_git_ancestor(fname)
  end,
}
