local nvim_status = require("lsp-status")

local M = {}

function LspStatus()
	if #vim.lsp.buf_get_clients() < 1 then
		return ""
	end
	return nvim_status.status()
end

M.select_symbol = function(cursor_pos, symbol)
	if symbol.valueRange then
		local value_range = {
			["start"] = {
				character = 0,
				line = vim.fn.byte2line(symbol.valueRange[1]),
			},
			["end"] = {
				character = 0,
				line = vim.fn.byte2line(symbol.valueRange[2]),
			},
		}

		return require("lsp-status.util").in_range(cursor_pos, value_range)
	end
end

M.activate = function()
	nvim_status.config({
		select_symbol = status.select_symbol,

		indicator_errors = "",
		indicator_warnings = "",
		indicator_info = "🛈",
		indicator_hint = "!",
		indicator_ok = "",
		spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
	})

	nvim_status.register_progress()
end

M.on_attach = function(client)
	nvim_status.on_attach(client)

	vim.cmd [[augroup lsp_status]]
	vim.cmd [[  autocmd CursorHold,BufEnter <buffer> lua require('lsp-status').update_current_function()]]
	vim.cmd [[augroup END]]
end

return M
