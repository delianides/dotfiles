local M = {}

function M.install_missing(servers)
  local lspi_servers = require "nvim-lsp-installer.servers"
  for server, _ in pairs(servers) do
    local ok, s = lspi_servers.get_server(server)
    if ok then
      if not s:is_installed() then
        s:install()
      end
    end
  end
end

function M.register_server(...) end

function M.setup(servers, options)
  local lspi = require "nvim-lsp-installer"
  local emmet_ls = require "configs.lsp.emmet"

  lspi.on_server_ready(function(server)
    local opts = vim.tbl_deep_extend("force", options, servers[server.name] or {})

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
  end)

  M.install_missing(servers)
end

return M
