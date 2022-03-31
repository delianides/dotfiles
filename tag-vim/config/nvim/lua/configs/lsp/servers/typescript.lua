local M = {}

function M.config(client)
	local status_ok, ts = pcall(require, "nvim-lsp-ts-utils")
	if not status_ok then
		return
	end

	-- vim.lsp.handlers["textDocument/codeAction"] = ts.code_action_handler
	ts.setup({
		debug = true,
		disable_commands = false,
		enable_import_on_completion = true,
		import_on_completion_timeout = 5000,
		eslint_bin = "eslint_d", -- use eslint_d if possible!
		eslint_enable_diagnostics = true,
		-- eslint_fix_current = true,
		eslint_enable_disable_comments = true,
		eslint_opts = {
			-- diagnostics_format = "#{m} [#{c}]",
			condition = function(utils)
				return utils.root_has_file(".eslintrc.js")
			end,
		},

		-- update imports on file move
		update_imports_on_move = true,
		require_confirmation_on_move = true,
		watch_dir = nil,

		-- filter diagnostics
		filter_out_diagnostics_by_severity = { "hint" },
		filter_out_diagnostics_by_code = {},
	})

	ts.setup_client(client)
end

return M
