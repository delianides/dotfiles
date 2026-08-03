-- Python LSP: pyrefly (selected via vim.g.lazyvim_python_lsp in config/options.lua)

-- Is `root`'s .envrc allowed by direnv? (direnv's allowed enum: 0 = allowed)
local function envrc_allowed(root)
  local out = vim.system({ "direnv", "status", "--json" }, { cwd = root, text = true }):wait(2000)
  if out.code ~= 0 or not out.stdout then
    return false
  end
  local ok, status = pcall(vim.json.decode, out.stdout)
  local found = ok and status.state and status.state.foundRC
  return found ~= nil and found.allowed == 0
end

-- Prefer the pyrefly the project pins over the Homebrew one, so the editor and
-- CI agree on versions. A .venv wins outright; otherwise, if the project has a
-- direnv env (nix) that this Neovim was not launched inside of, go through
-- `direnv exec` so both pyrefly and the Python it queries come from that env.
local function pyrefly_cmd(root)
  if not root then
    return { "pyrefly", "lsp" }
  end

  local venv = root .. "/.venv/bin/pyrefly"
  if vim.uv.fs_stat(venv) then
    return { venv, "lsp" }
  end

  local loaded = (vim.env.DIRENV_DIR or ""):gsub("^%-", "")
  if
    loaded ~= root
    and vim.uv.fs_stat(root .. "/.envrc")
    and vim.fn.executable("direnv") == 1
    and envrc_allowed(root)
  then
    return { "direnv", "exec", root, "pyrefly", "lsp" }
  end

  return { "pyrefly", "lsp" }
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyrefly = {
          -- resolved per project root; Homebrew's pyrefly is the fallback
          mason = false,
          cmd = function(dispatchers, config)
            return vim.lsp.rpc.start(pyrefly_cmd(config.root_dir), dispatchers, { cwd = config.root_dir })
          end,
        },
      },
    },
  },
}
