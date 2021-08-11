local download_packer = function()
  if vim.fn.input "Download Packer? (y for yes)" ~= "y" then
    return
  end

  local directory = string.format("%s/site/pack/packer/start/", vim.fn.stdpath "data")

  vim.fn.mkdir(directory, "p")

  local out = vim.fn.system(
    string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
  )

  print(out)
  print "Downloading packer.nvim..."
  print "( You'll need to restart now )"
end

if not pcall(require, "packer") then
  download_packer()
end

P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, "plenary") then
  RELOAD = require("plenary.reload").reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

require "modules.packer" -- plugins with packer
require "modules.settings" -- general vim config
require "modules.keymaps" -- key mappings
require "modules.lsp" -- Builtin Neovim LSP config
require "modules.completion" -- autocompletion using nvim-compe
require "modules.telescope" -- Load Telescope Config
require "modules.telescope.mappings" -- telescope specfic mappings

vim.cmd [[autocmd BufWritePost ~/.config/nvim/*.lua so % | PackerCompile | so ~/.config/nvim/init.lua]]
