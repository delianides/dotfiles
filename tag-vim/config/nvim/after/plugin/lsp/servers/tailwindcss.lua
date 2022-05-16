local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
    return
end

lspconfig.tailwindcss.setup {
  root_dir = function(fname)
    return lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts")(fname) -- only if theres a tailwind config
  end,
}



