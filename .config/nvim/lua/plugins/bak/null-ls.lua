return {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufReadPre",
	opts = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics
		local code_actions = null_ls.builtins.code_actions
		local completion = null_ls.builtins.completion
		return {
			debug = true,
			sources = {
				formatting.shfmt,
				formatting.stylua,
				formatting.prettier,
				formatting.clang_format,
				formatting.black.with({ extra_args = { "--fast" } }),
				diagnostics.trail_space,
				code_actions.gitsigns,
				code_actions.cspell,
				require("typescript.extensions.null-ls.code-actions"),
			},
			on_attach = function(current_client, bufnr)
				if current_client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								filter = function(client)
									--  only use null-ls for formatting instead of lsp server
									return client.name == "null-ls"
								end,
								bufnr = bufnr,
							})
						end,
					})
				end
			end,
		}
	end,
}
