local M = {}

-- https://gist.github.com/beauwilliams/05c02c7b957615498fd39012316b791b
-- @USAGE:
-- local foo = safe_require('foo')
-- if not foo then return end
_G.safe_require = function(module_name)
	local package_exists, module = pcall(require, module_name)
	if not package_exists then
		vim.defer_fn(function()
			vim.schedule(function()
				vim.notify("Could not load module: " .. module_name, "error", { title = "Module Not Found" })
			end)
		end, 1000)
		return nil
	else
		return module
	end
end

_G.toggle_config = function(option, silent)
	local info = vim.api.nvim_get_option_info(option)
	local scopes = { buf = "bo", win = "wo", global = "o" }
	local scope = scopes[info.scope]
	local options = vim[scope]
	options[option] = not options[option]
	if silent ~= true then
		if options[option] then
			vim.notify("enabled vim." .. scope .. "." .. option, "info", { title = "Toggle Config" })
		else
			vim.notify("disabled vim." .. scope .. "." .. option, "info", { title = "Toggle Config" })
		end
	end
end

local g = vim.g

function M.bootstrap()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		PACKER_BOOTSTRAP = fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		})
		print("Cloning packer...\nSetup AstroVim")
		vim.cmd([[packadd packer.nvim]])
	end
end

function M.disabled_builtins()
	g.loaded_2html_plugin = false
	g.loaded_getscript = false
	g.loaded_getscriptPlugin = false
	g.loaded_gzip = false
	g.loaded_logipat = false
	g.loaded_netrwFileHandlers = false
	g.loaded_netrwPlugin = false
	g.loaded_netrwSettngs = false
	g.loaded_remote_plugins = false
	g.loaded_tar = false
	g.loaded_tarPlugin = false
	g.loaded_zip = false
	g.loaded_zipPlugin = false
	g.loaded_vimball = false
	g.loaded_vimballPlugin = false
	g.zipPlugin = false
  g.should_run_prettier = false
end

function M.list_registered_providers_names(filetype)
	local s = require("null-ls.sources")
	local available_sources = s.get_available(filetype)
	local registered = {}
	for _, source in ipairs(available_sources) do
		for method in pairs(source.methods) do
			registered[method] = registered[method] or {}
			table.insert(registered[method], source.name)
		end
	end
	return registered
end

function M.list_registered_formatters(filetype)
	local null_ls_methods = require("null-ls.methods")
	local formatter_method = null_ls_methods.internal["FORMATTING"]
	local registered_providers = M.list_registered_providers_names(filetype)
	return registered_providers[formatter_method] or {}
end

function M.list_registered_linters(filetype)
	local null_ls_methods = require("null-ls.methods")
	local formatter_method = null_ls_methods.internal["DIAGNOSTICS"]
	local registered_providers = M.list_registered_providers_names(filetype)
	return registered_providers[formatter_method] or {}
end

function M.add_cmp_source(source)
	local cmp_ok, cmp = pcall(require, "cmp")
	if cmp_ok then
		local config = cmp.get_config()
		table.insert(config.sources, { name = source })
		cmp.setup(config)
	end
end

function M.t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.log(msg, hl, name)
	name = name or "Neovim"
	hl = hl or "Todo"
	vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

function M.warn(msg, name)
	M.log(msg, "LspDiagnosticsDefaultWarning", name)
end

function M.error(msg, name)
	M.log(msg, "LspDiagnosticsDefaultError", name)
end

function M.info(msg, name)
	M.log(msg, "LspDiagnosticsDefaultInformation", name)
end

function M.execute(id)
	local func = M.functions[id]
	if not func then
		error("Function doest not exist: " .. id)
	end
	return func()
end

M.functions = {}

local map = function(mode, key, cmd, opts, defaults)
	opts = vim.tbl_deep_extend("force", { silent = true }, defaults or {}, opts or {})

	if type(cmd) == "function" then
		table.insert(M.functions, cmd)
		if opts.expr then
			cmd = ([[luaeval('require("core.utils").execute(%d)')]]):format(#M.functions)
		else
			cmd = ("<cmd>lua require('core.utils').execute(%d)<cr>"):format(#M.functions)
		end
	end
	if opts.buffer ~= nil then
		local buffer = opts.buffer
		opts.buffer = nil
		return vim.api.nvim_buf_set_keymap(buffer, mode, key, cmd, opts)
	else
		return vim.api.nvim_set_keymap(mode, key, cmd, opts)
	end
end

function M.map(mode, key, cmd, opt, defaults)
	return map(mode, key, cmd, opt, defaults)
end

function M.cmap(key, cmd, opts)
	return map("c", key, cmd, opts)
end

function M.nmap(key, cmd, opts)
	return map("n", key, cmd, opts)
end

function M.vmap(key, cmd, opts)
	return map("v", key, cmd, opts)
end

function M.xmap(key, cmd, opts)
	return map("x", key, cmd, opts)
end

function M.imap(key, cmd, opts)
	return map("i", key, cmd, opts)
end

function M.omap(key, cmd, opts)
	return map("o", key, cmd, opts)
end

function M.smap(key, cmd, opts)
	return map("s", key, cmd, opts)
end

function M.tmap(key, cmd, opts)
	return map("t", key, cmd, opts)
end

function M.cnoremap(key, cmd, opts)
	return map("c", key, cmd, opts, { noremap = true })
end

function M.nnoremap(key, cmd, opts)
	return map("n", key, cmd, opts, { noremap = true })
end

function M.vnoremap(key, cmd, opts)
	return map("v", key, cmd, opts, { noremap = true })
end

function M.xnoremap(key, cmd, opts)
	return map("x", key, cmd, opts, { noremap = true })
end

function M.inoremap(key, cmd, opts)
	return map("i", key, cmd, opts, { noremap = true })
end

function M.onoremap(key, cmd, opts)
	return map("o", key, cmd, opts, { noremap = true })
end

function M.snoremap(key, cmd, opts)
	return map("s", key, cmd, opts, { noremap = true })
end

function M.tnoremap(key, cmd, opts)
	return map("t", key, cmd, opts, { noremap = true })
end

return M
