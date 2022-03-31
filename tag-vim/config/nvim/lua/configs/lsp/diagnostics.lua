local M = {}

function M.config()
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = false,
		update_in_insert = true,
		virtual_text = false,
		severity_sort = true,
	})

	local signs = { Error = "E ", Warn = "W ", Hint = "H ", Info = "I " }

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end
end

return M
