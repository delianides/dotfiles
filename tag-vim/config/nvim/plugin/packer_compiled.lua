-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = true
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/adelianides/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/adelianides/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/adelianides/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/adelianides/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/adelianides/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\21configs.comments\frequire\0" },
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["FixCursorHold.nvim"] = {
    config = { "\27LJ\2\n7\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1d\0=\1\2\0K\0\1\0\26cursorhold_updatetime\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\20configs.luasnip\frequire\0" },
    load_after = {
      ["friendly-snippets"] = true
    },
    loaded = false,
    needs_bufread = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["SchemaStore.nvim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/SchemaStore.nvim",
    url = "https://github.com/b0o/SchemaStore.nvim"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\nA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\23configs.bufferline\frequire\0" },
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["circles.nvim"] = {
    config = { "\27LJ\2\nq\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\nicons\1\0\0\1\0\3\vfilled\bï„Œ\nempty\bï„‘\15lsp_prefix\bï„‘\nsetup\fcircles\frequire\0" },
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/circles.nvim",
    url = "https://github.com/projekt0n/circles.nvim"
  },
  ["cmp-buffer"] = {
    after_files = { "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    config = { "\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\vbuffer\19add_cmp_source\15core.utils\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    config = { "\27LJ\2\nN\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rnvim_lsp\19add_cmp_source\15core.utils\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    after_files = { "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    config = { "\27LJ\2\nJ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\tpath\19add_cmp_source\15core.utils\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    after_files = { "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    config = { "\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\fluasnip\19add_cmp_source\15core.utils\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["colorbuddy.vim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/colorbuddy.vim",
    url = "https://github.com/tjdevries/colorbuddy.vim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["dressing.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["filetype.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rfiletype\frequire\0" },
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/filetype.nvim",
    url = "https://github.com/nathom/filetype.nvim"
  },
  ["friendly-snippets"] = {
    after = { "LuaSnip" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["git-worktree.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17git-worktree\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/git-worktree.nvim",
    url = "https://github.com/ThePrimeagen/git-worktree.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\21configs.gitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["glow.nvim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/glow.nvim",
    url = "https://github.com/ellisonleao/glow.nvim"
  },
  ["goyo.vim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/goyo.vim",
    url = "https://github.com/junegunn/goyo.vim"
  },
  ["gruvbuddy.nvim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/gruvbuddy.nvim",
    url = "https://github.com/tjdevries/gruvbuddy.nvim"
  },
  harpoon = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\20configs.harpoon\frequire\0" },
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/harpoon",
    url = "https://github.com/ThePrimeagen/harpoon"
  },
  ["html5.vim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/html5.vim",
    url = "https://github.com/othree/html5.vim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22configs.blankline\frequire\0" },
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["javascript-libraries-syntax.vim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/javascript-libraries-syntax.vim",
    url = "https://github.com/othree/javascript-libraries-syntax.vim"
  },
  ["kanagawa.nvim"] = {
    config = { "\27LJ\2\n“\2\0\0\4\0\6\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0024\3\0\0=\3\5\2B\0\2\1K\0\1\0\14overrides\vcolors\1\0\n\25variablebuiltinStyle\vitalic\18specialReturn\2\21specialException\2\16transparent\1\16dimInactive\1\17commentStyle\vitalic\18functionStyle\tNONE\17keywordStyle\vitalic\19statementStyle\tbold\14typeStyle\tNONE\nsetup\rkanagawa\frequire\0" },
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["limelight.vim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/limelight.vim",
    url = "https://github.com/junegunn/limelight.vim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim",
    url = "https://github.com/nvim-lua/lsp_extensions.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/lua-dev.nvim",
    url = "https://github.com/folke/lua-dev.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\20configs.lualine\frequire\0" },
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/hoob3rt/lualine.nvim"
  },
  neogit = {
    config = { "\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\19configs.neogit\frequire\0" },
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\22configs.autopairs\frequire\0" },
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "cmp-buffer", "cmp-path", "cmp_luasnip", "cmp-nvim-lsp" },
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\16configs.cmp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\22configs.colorizer\frequire\0" },
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lsp-ts-utils"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/nvim-lsp-ts-utils",
    url = "https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16configs.lsp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig",
    wants = { "nvim-lsp-ts-utils", "null-ls.nvim", "lua-dev.nvim", "cmp-nvim-lsp", "lsp-status.nvim", "nvim-lsp-installer" }
  },
  ["nvim-toggleterm.lua"] = {
    config = { "\27LJ\2\nA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\23configs.toggleterm\frequire\0" },
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua",
    url = "https://github.com/akinsho/nvim-toggleterm.lua"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-treesitter-textobjects", "nvim-ts-rainbow", "nvim-treesitter-textsubjects", "nvim-ts-context-commentstring", "nvim-ts-autotag" },
    commands = { "TSInstall", "TSInstallInfo", "TSInstallSync", "TSUninstall", "TSUpdate", "TSUpdateSync", "TSDisableAll", "TSEnableAll" },
    config = { "require('configs.treesitter')" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-treesitter-textsubjects"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textsubjects",
    url = "https://github.com/RRethy/nvim-treesitter-textsubjects"
  },
  ["nvim-ts-autotag"] = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\20configs.autotag\frequire\0" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["octo.nvim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/octo.nvim",
    url = "https://github.com/pwntester/octo.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["parinfer-rust"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/parinfer-rust",
    url = "https://github.com/eraserhd/parinfer-rust"
  },
  ["plenary.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["pretty-fold.nvim"] = {
    config = { "\27LJ\2\n@\0\0\4\0\6\0\a6\0\0\0009\0\1\0'\2\2\0006\3\3\0009\3\4\0039\3\5\3D\0\3\0\14foldlevel\6v\bvim\6-\brep\vstringÜ\1\1\0\6\0\n\0\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\6\0005\4\4\0003\5\5\0>\5\2\4=\4\a\3=\3\b\2B\0\2\0016\0\0\0'\2\t\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\24pretty-fold.preview\rsections\tleft\1\0\0\0\1\a\0\0\6+\0\6 \27number_of_folded_lines\6:\fcontent\1\0\2\21keep_indentation\1\14fill_char\bâ€¢\nsetup\16pretty-fold\frequire\0" },
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/pretty-fold.nvim",
    url = "https://github.com/anuvyklack/pretty-fold.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["rust.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/rust.vim",
    url = "https://github.com/rust-lang/rust.vim"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/splitjoin.vim",
    url = "https://github.com/AndrewRadev/splitjoin.vim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzy-native.nvim"
  },
  ["telescope-github.nvim"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/telescope-github.nvim",
    url = "https://github.com/nvim-telescope/telescope-github.nvim"
  },
  ["telescope.nvim"] = {
    after = { "git-worktree.nvim" },
    loaded = true,
    only_config = true
  },
  ["trouble.nvim"] = {
    commands = { "TroubleToggle", "Trouble" },
    config = { "require('configs.trouble')" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim",
    wants = { "nvim-web-devicons" }
  },
  undotree = {
    commands = { "UndotreeToggle" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-characterize"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-characterize",
    url = "https://github.com/tpope/vim-characterize"
  },
  ["vim-css3-syntax"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-css3-syntax",
    url = "https://github.com/hail2u/vim-css3-syntax"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["vim-go"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/vim-go",
    url = "https://github.com/fatih/vim-go"
  },
  ["vim-html-escape"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-html-escape",
    url = "https://github.com/skwp/vim-html-escape"
  },
  ["vim-illuminate"] = {
    config = { "\27LJ\2\n2\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1è\3=\1\2\0K\0\1\0\21Illuminate_delay\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-jsdoc"] = {
    commands = { "JsDoc" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/vim-jsdoc",
    url = "https://github.com/heavenshell/vim-jsdoc"
  },
  ["vim-jsx-pretty"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-jsx-pretty",
    url = "https://github.com/MaxMEllon/vim-jsx-pretty"
  },
  ["vim-mdx-js"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-mdx-js",
    url = "https://github.com/jxnblk/vim-mdx-js"
  },
  ["vim-node"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/vim-node",
    url = "https://github.com/moll/vim-node"
  },
  ["vim-racer"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-racer",
    url = "https://github.com/racer-rust/vim-racer"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-solidity"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-solidity",
    url = "https://github.com/tomlion/vim-solidity"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-svelte-plugin"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-svelte-plugin",
    url = "https://github.com/leafOfTree/vim-svelte-plugin"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-test",
    url = "https://github.com/vim-test/vim-test"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-textobj-user",
    url = "https://github.com/kana/vim-textobj-user"
  },
  ["vim-textobj-xmlattr"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-textobj-xmlattr",
    url = "https://github.com/whatyouhide/vim-textobj-xmlattr"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["vim-ultest"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-ultest",
    url = "https://github.com/rcarriga/vim-ultest"
  },
  ["vim-vue"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-vue",
    url = "https://github.com/posva/vim-vue"
  },
  ["vim-yaml-folds"] = {
    loaded = true,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/start/vim-yaml-folds",
    url = "https://github.com/pedrohdz/vim-yaml-folds"
  },
  ["yajs.vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/yajs.vim",
    url = "https://github.com/othree/yajs.vim"
  },
  ["yats.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/adelianides/.local/share/nvim/site/pack/packer/opt/yats.vim",
    url = "https://github.com/HerringtonDarkholme/yats.vim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^illuminate"] = "vim-illuminate",
  ["^plenary"] = "plenary.nvim",
  ["^popup"] = "popup.nvim",
  ["^rust%-tools"] = "rust-tools.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Config for: filetype.nvim
time([[Config for filetype.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rfiletype\frequire\0", "config", "filetype.nvim")
time([[Config for filetype.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\22configs.autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: nvim-toggleterm.lua
time([[Config for nvim-toggleterm.lua]], true)
try_loadstring("\27LJ\2\nA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\23configs.toggleterm\frequire\0", "config", "nvim-toggleterm.lua")
time([[Config for nvim-toggleterm.lua]], false)
-- Config for: kanagawa.nvim
time([[Config for kanagawa.nvim]], true)
try_loadstring("\27LJ\2\n“\2\0\0\4\0\6\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0024\3\0\0=\3\5\2B\0\2\1K\0\1\0\14overrides\vcolors\1\0\n\25variablebuiltinStyle\vitalic\18specialReturn\2\21specialException\2\16transparent\1\16dimInactive\1\17commentStyle\vitalic\18functionStyle\tNONE\17keywordStyle\vitalic\19statementStyle\tbold\14typeStyle\tNONE\nsetup\rkanagawa\frequire\0", "config", "kanagawa.nvim")
time([[Config for kanagawa.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\20configs.lualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\22configs.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: circles.nvim
time([[Config for circles.nvim]], true)
try_loadstring("\27LJ\2\nq\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\nicons\1\0\0\1\0\3\vfilled\bï„Œ\nempty\bï„‘\15lsp_prefix\bï„‘\nsetup\fcircles\frequire\0", "config", "circles.nvim")
time([[Config for circles.nvim]], false)
-- Config for: pretty-fold.nvim
time([[Config for pretty-fold.nvim]], true)
try_loadstring("\27LJ\2\n@\0\0\4\0\6\0\a6\0\0\0009\0\1\0'\2\2\0006\3\3\0009\3\4\0039\3\5\3D\0\3\0\14foldlevel\6v\bvim\6-\brep\vstringÜ\1\1\0\6\0\n\0\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\6\0005\4\4\0003\5\5\0>\5\2\4=\4\a\3=\3\b\2B\0\2\0016\0\0\0'\2\t\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\24pretty-fold.preview\rsections\tleft\1\0\0\0\1\a\0\0\6+\0\6 \27number_of_folded_lines\6:\fcontent\1\0\2\21keep_indentation\1\14fill_char\bâ€¢\nsetup\16pretty-fold\frequire\0", "config", "pretty-fold.nvim")
time([[Config for pretty-fold.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\21configs.comments\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\22configs.colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
try_loadstring("\27LJ\2\nA\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\23configs.bufferline\frequire\0", "config", "bufferline.nvim")
time([[Config for bufferline.nvim]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22configs.blankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: neogit
time([[Config for neogit]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\19configs.neogit\frequire\0", "config", "neogit")
time([[Config for neogit]], false)
-- Config for: harpoon
time([[Config for harpoon]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\20configs.harpoon\frequire\0", "config", "harpoon")
time([[Config for harpoon]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd git-worktree.nvim ]]

-- Config for: git-worktree.nvim
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17git-worktree\frequire\0", "config", "git-worktree.nvim")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSEnableAll lua require("packer.load")({'nvim-treesitter'}, { cmd = "TSEnableAll", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file JsDoc lua require("packer.load")({'vim-jsdoc'}, { cmd = "JsDoc", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file UndotreeToggle lua require("packer.load")({'undotree'}, { cmd = "UndotreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Trouble lua require("packer.load")({'trouble.nvim'}, { cmd = "Trouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TroubleToggle lua require("packer.load")({'trouble.nvim'}, { cmd = "TroubleToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSInstall lua require("packer.load")({'nvim-treesitter'}, { cmd = "TSInstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSInstallInfo lua require("packer.load")({'nvim-treesitter'}, { cmd = "TSInstallInfo", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSInstallSync lua require("packer.load")({'nvim-treesitter'}, { cmd = "TSInstallSync", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSUninstall lua require("packer.load")({'nvim-treesitter'}, { cmd = "TSUninstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSUpdate lua require("packer.load")({'nvim-treesitter'}, { cmd = "TSUpdate", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSUpdateSync lua require("packer.load")({'nvim-treesitter'}, { cmd = "TSUpdateSync", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSDisableAll lua require("packer.load")({'nvim-treesitter'}, { cmd = "TSDisableAll", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType golang ++once lua require("packer.load")({'vim-go'}, { ft = "golang" }, _G.packer_plugins)]]
vim.cmd [[au FileType rust ++once lua require("packer.load")({'rust.vim'}, { ft = "rust" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'yats.vim'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript.jsx ++once lua require("packer.load")({'yajs.vim', 'vim-jsdoc'}, { ft = "javascript.jsx" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'yajs.vim'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript.tsx ++once lua require("packer.load")({'yats.vim'}, { ft = "typescript.tsx" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'yajs.vim', 'vim-jsdoc', 'vim-node'}, { ft = "javascript" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-treesitter', 'nvim-cmp', 'FixCursorHold.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au CursorHold * ++once lua require("packer.load")({'vim-illuminate'}, { event = "CursorHold *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'friendly-snippets'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'nvim-lspconfig', 'dressing.nvim', 'trouble.nvim', 'gitsigns.nvim'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/adelianides/.local/share/nvim/site/pack/packer/opt/yats.vim/ftdetect/typescript.vim]], true)
vim.cmd [[source /Users/adelianides/.local/share/nvim/site/pack/packer/opt/yats.vim/ftdetect/typescript.vim]]
time([[Sourcing ftdetect script at: /Users/adelianides/.local/share/nvim/site/pack/packer/opt/yats.vim/ftdetect/typescript.vim]], false)
time([[Sourcing ftdetect script at: /Users/adelianides/.local/share/nvim/site/pack/packer/opt/yats.vim/ftdetect/typescriptreact.vim]], true)
vim.cmd [[source /Users/adelianides/.local/share/nvim/site/pack/packer/opt/yats.vim/ftdetect/typescriptreact.vim]]
time([[Sourcing ftdetect script at: /Users/adelianides/.local/share/nvim/site/pack/packer/opt/yats.vim/ftdetect/typescriptreact.vim]], false)
time([[Sourcing ftdetect script at: /Users/adelianides/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]], true)
vim.cmd [[source /Users/adelianides/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]]
time([[Sourcing ftdetect script at: /Users/adelianides/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]], false)
time([[Sourcing ftdetect script at: /Users/adelianides/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]], true)
vim.cmd [[source /Users/adelianides/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]]
time([[Sourcing ftdetect script at: /Users/adelianides/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]], false)
time([[Sourcing ftdetect script at: /Users/adelianides/.local/share/nvim/site/pack/packer/opt/vim-node/ftdetect/node.vim]], true)
vim.cmd [[source /Users/adelianides/.local/share/nvim/site/pack/packer/opt/vim-node/ftdetect/node.vim]]
time([[Sourcing ftdetect script at: /Users/adelianides/.local/share/nvim/site/pack/packer/opt/vim-node/ftdetect/node.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles(0) end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
