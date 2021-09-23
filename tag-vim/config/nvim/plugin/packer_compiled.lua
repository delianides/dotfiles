-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
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
local package_path_str = "/Users/drew/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/drew/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/drew/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/drew/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/drew/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
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
  ["JavaScript-Indent"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/opt/JavaScript-Indent"
  },
  ["architext.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/architext.nvim"
  },
  ["astronauta.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/astronauta.nvim"
  },
  ["circles.nvim"] = {
    config = { "\27LJ\2\nq\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\nicons\1\0\0\1\0\3\vfilled\bï„Œ\15lsp_prefix\bï„‘\nempty\bï„‘\nsetup\fcircles\frequire\0" },
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/circles.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["colorbuddy.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/colorbuddy.nvim"
  },
  ["committia.vim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/committia.vim"
  },
  ["far.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/opt/far.vim"
  },
  ["formatter.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/formatter.nvim"
  },
  ["git-messenger.vim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/git-messenger.vim"
  },
  ["git-worktree.nvim"] = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\17git-worktree\frequire\0" },
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/git-worktree.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["goyo.vim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/goyo.vim"
  },
  ["gundo.vim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/gundo.vim"
  },
  harpoon = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/harpoon"
  },
  ["java-syntax.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/opt/java-syntax.vim"
  },
  ["javascript-libraries-syntax.vim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/javascript-libraries-syntax.vim"
  },
  ["limelight.vim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/limelight.vim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-terminal.lua"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rterminal\frequire\0" },
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/nvim-terminal.lua"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n‡\1\0\1\t\0\6\0\0236\1\0\0\18\3\0\0B\1\2\4H\4\16€6\6\1\0\18\b\5\0B\6\2\2\a\6\2\0X\6\5€\15\0\5\0X\6\2€)\5\1\0X\6\1€)\5\0\0006\6\3\0009\6\4\6'\a\5\0\18\b\4\0&\a\b\a<\5\a\6F\4\3\3R\4îK\0\1\0\15nvim_tree_\6g\bvim\fboolean\ttype\npairsè\1\1\0\5\0\4\0\a3\0\0\0\18\1\0\0005\3\1\0005\4\2\0=\4\3\3B\1\2\1K\0\1\0\vignore\1\5\0\0\t.git\17node_modules\v.cache\16__pycache__\1\0\t\18hide_dotfiles\1\16auto_resize\2\27highlight_opened_files\2\vfollow\2\23width_allow_resize\2\14tree_side\tleft\14auto_open\2\26disable_window_picker\2\19indent_markers\2\0\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n…\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    config = { "\27LJ\2\nV\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\venable\2\nsetup\30treesitter-context.config\frequire\0" },
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring"
  },
  ["nvim-ts-hint-textobject"] = {
    config = { "\27LJ\2\n¢\1\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0009vnoremap <silent> m :lua require('tsht').nodes()<CR>>omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/nvim-ts-hint-textobject"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["parinfer-rust"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/parinfer-rust"
  },
  playground = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["rofl.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/rofl.nvim"
  },
  ["rust.vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/opt/rust.vim"
  },
  semshi = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/opt/semshi"
  },
  ["snippets.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/snippets.nvim"
  },
  sonokai = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/sonokai"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/splitjoin.vim"
  },
  ["tabline.nvim"] = {
    config = { "\27LJ\2\nD\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\venable\1\nsetup\ftabline\frequire\0" },
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/tabline.nvim"
  },
  tabular = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/tabular"
  },
  ["telescope-cheat.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/telescope-cheat.nvim"
  },
  ["telescope-frecency.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["telescope-fzf-writer.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/telescope-fzf-writer.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope-github.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/telescope-github.nvim"
  },
  ["telescope-packer.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/telescope-packer.nvim"
  },
  ["telescope-symbols.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/telescope-symbols.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\14auto_fold\2\17auto_preview\1\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ["typescript-vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/opt/typescript-vim"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-boxdraw"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/vim-boxdraw"
  },
  ["vim-characterize"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/vim-characterize"
  },
  ["vim-closer"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/vim-closer"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/vim-dispatch"
  },
  ["vim-go"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/opt/vim-go"
  },
  ["vim-inyoface"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/vim-inyoface"
  },
  ["vim-json"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/opt/vim-json"
  },
  ["vim-jsx-pretty"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/vim-jsx-pretty"
  },
  ["vim-node"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/opt/vim-node"
  },
  ["vim-protocol"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/vim-protocol"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-solidity"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/vim-solidity"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/vim-test"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator"
  },
  ["vim-toml"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/opt/vim-toml"
  },
  ["vim-ultest"] = {
    config = { "\27LJ\2\nu\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0%nmap [t <Plug>(ultest-prev-fail)%nmap ]t <Plug>(ultest-next-fail)\bcmd\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/opt/vim-ultest"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    loaded = true,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/start/vim-vsnip-integ"
  },
  ["yajs.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/drew/.local/share/nvim/site/pack/packer/opt/yajs.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n…\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-ts-hint-textobject
time([[Config for nvim-ts-hint-textobject]], true)
try_loadstring("\27LJ\2\n¢\1\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0009vnoremap <silent> m :lua require('tsht').nodes()<CR>>omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>\bcmd\bvim\0", "config", "nvim-ts-hint-textobject")
time([[Config for nvim-ts-hint-textobject]], false)
-- Config for: nvim-terminal.lua
time([[Config for nvim-terminal.lua]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rterminal\frequire\0", "config", "nvim-terminal.lua")
time([[Config for nvim-terminal.lua]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\14auto_fold\2\17auto_preview\1\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: circles.nvim
time([[Config for circles.nvim]], true)
try_loadstring("\27LJ\2\nq\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\nicons\1\0\0\1\0\3\vfilled\bï„Œ\15lsp_prefix\bï„‘\nempty\bï„‘\nsetup\fcircles\frequire\0", "config", "circles.nvim")
time([[Config for circles.nvim]], false)
-- Config for: nvim-treesitter-context
time([[Config for nvim-treesitter-context]], true)
try_loadstring("\27LJ\2\nV\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\venable\2\nsetup\30treesitter-context.config\frequire\0", "config", "nvim-treesitter-context")
time([[Config for nvim-treesitter-context]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: tabline.nvim
time([[Config for tabline.nvim]], true)
try_loadstring("\27LJ\2\nD\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\venable\1\nsetup\ftabline\frequire\0", "config", "tabline.nvim")
time([[Config for tabline.nvim]], false)
-- Config for: git-worktree.nvim
time([[Config for git-worktree.nvim]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\17git-worktree\frequire\0", "config", "git-worktree.nvim")
time([[Config for git-worktree.nvim]], false)
-- Conditional loads
time("Condition for { 'far.vim', 'vim-ultest' }", true)
if
try_loadstring("\27LJ\2\nG\0\0\3\0\4\1\v6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\b\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\fpython3\bhas\afn\bvim\2\0", "condition", '{ "far.vim", "vim-ultest" }')
then
time("Condition for { 'far.vim', 'vim-ultest' }", false)
time([[packadd for far.vim]], true)
		vim.cmd [[packadd far.vim]]
	time([[packadd for far.vim]], false)
	time([[packadd for vim-ultest]], true)
		vim.cmd [[packadd vim-ultest]]
	time([[packadd for vim-ultest]], false)
	-- Config for: vim-ultest
	time([[Config for vim-ultest]], true)
	try_loadstring("\27LJ\2\nu\0\0\3\0\4\0\t6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\0\0009\0\1\0'\2\3\0B\0\2\1K\0\1\0%nmap [t <Plug>(ultest-prev-fail)%nmap ]t <Plug>(ultest-next-fail)\bcmd\bvim\0", "config", "vim-ultest")
	time([[Config for vim-ultest]], false)
else
time("Condition for { 'far.vim', 'vim-ultest' }", false)
end
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType rust ++once lua require("packer.load")({'rust.vim'}, { ft = "rust" }, _G.packer_plugins)]]
vim.cmd [[au FileType java ++once lua require("packer.load")({'java-syntax.vim'}, { ft = "java" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'semshi'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'vim-node', 'yajs.vim', 'JavaScript-Indent'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript.jsx ++once lua require("packer.load")({'yajs.vim'}, { ft = "javascript.jsx" }, _G.packer_plugins)]]
vim.cmd [[au FileType json ++once lua require("packer.load")({'vim-json'}, { ft = "json" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript.tsx ++once lua require("packer.load")({'typescript-vim'}, { ft = "typescript.tsx" }, _G.packer_plugins)]]
vim.cmd [[au FileType golang ++once lua require("packer.load")({'vim-go'}, { ft = "golang" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'yajs.vim'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'typescript-vim'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType toml ++once lua require("packer.load")({'vim-toml'}, { ft = "toml" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/drew/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]], true)
vim.cmd [[source /Users/drew/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]]
time([[Sourcing ftdetect script at: /Users/drew/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]], false)
time([[Sourcing ftdetect script at: /Users/drew/.local/share/nvim/site/pack/packer/opt/vim-json/ftdetect/json.vim]], true)
vim.cmd [[source /Users/drew/.local/share/nvim/site/pack/packer/opt/vim-json/ftdetect/json.vim]]
time([[Sourcing ftdetect script at: /Users/drew/.local/share/nvim/site/pack/packer/opt/vim-json/ftdetect/json.vim]], false)
time([[Sourcing ftdetect script at: /Users/drew/.local/share/nvim/site/pack/packer/opt/vim-node/ftdetect/node.vim]], true)
vim.cmd [[source /Users/drew/.local/share/nvim/site/pack/packer/opt/vim-node/ftdetect/node.vim]]
time([[Sourcing ftdetect script at: /Users/drew/.local/share/nvim/site/pack/packer/opt/vim-node/ftdetect/node.vim]], false)
time([[Sourcing ftdetect script at: /Users/drew/.local/share/nvim/site/pack/packer/opt/vim-toml/ftdetect/toml.vim]], true)
vim.cmd [[source /Users/drew/.local/share/nvim/site/pack/packer/opt/vim-toml/ftdetect/toml.vim]]
time([[Sourcing ftdetect script at: /Users/drew/.local/share/nvim/site/pack/packer/opt/vim-toml/ftdetect/toml.vim]], false)
time([[Sourcing ftdetect script at: /Users/drew/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]], true)
vim.cmd [[source /Users/drew/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]]
time([[Sourcing ftdetect script at: /Users/drew/.local/share/nvim/site/pack/packer/opt/rust.vim/ftdetect/rust.vim]], false)
time([[Sourcing ftdetect script at: /Users/drew/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim]], true)
vim.cmd [[source /Users/drew/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim]]
time([[Sourcing ftdetect script at: /Users/drew/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
