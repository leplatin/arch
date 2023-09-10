return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
		"jose-elias-alvarez/typescript.nvim",
	},
	config = function(_, _)
		local mason_lspconfig = require("mason-lspconfig")
		local lspconfig = require("lspconfig")
		local typescript = require("typescript")
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		vim.diagnostic.config({
			virtual_text = false,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
			signs = true,
			underline = true,
			update_in_insert = true,
			severity_sort = false,
		})

		local signs = { Error = " ", Warn = "ﴞ ", Hint = " ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		local on_attach = function(client, bufnr)
			-- Enable completion triggered by <c-x><c-o>
			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", bufopts) -- show definition, references
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts) -- got to declaration
			vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", bufopts) -- see definition and make edits in window
			vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", bufopts) -- go to implementation
			vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", bufopts) -- go to implementation
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts) -- see available code actions
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts) -- see available code actions, in visual mode will apply to selection
			vim.keymap.set("n", "<leader>rn", ":IncRename ", bufopts) -- smart rename
			vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", bufopts) -- show  diagnostics for file
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, bufopts) -- show diagnostics for line
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts) -- jump to previous diagnostic in buffer
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts) -- jump to next diagnostic in buffer
			vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- show documentation for what is under cursor

			-- typescript specific keymaps (e.g. rename file and update imports)
			if client.name == "tsserver" then
				vim.keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
				vim.keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
				vim.keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
			end

			vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, bufopts)
			vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
			vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
			vim.keymap.set("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, bufopts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
			-- show diagnostics in hover window
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					local opts = {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
						border = "rounded",
						source = "always",
						prefix = " ",
						scope = "cursor",
					}
					vim.diagnostic.open_float(nil, opts)
				end,
			})
		end

		mason_lspconfig.setup({
			ensure_installed = {
				"clangd",
				"tsserver",
				"pyright",
				"lua_ls",
				"eslint",
				"bashls",
				"yamlls",
				"jsonls",
				"cssls",
				"tailwindcss",
				"html",
				"emmet_ls",
				--    "taplo",
				--    "graphql",
				--    "gopls",
			},
		})

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,

			["pyright"] = function()
				lspconfig.pyright.setup({
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						python = {
							analysis = {
								typeCheckingMode = "off",
							},
						},
					},
				})
			end,

			["html"] = function()
				lspconfig.html.setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,

			["cssls"] = function()
				lspconfig.cssls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,

			["tailwindcss"] = function()
				lspconfig.tailwindcss.setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,

			["emmet_ls"] = function()
				lspconfig.emmet_ls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					filetypes = {
						"html",
						"typescriptreact",
						"javascriptreact",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
					},
				})
			end,

			["clangd"] = function()
				local capabilities_cpp = capabilities
				capabilities_cpp.offsetEncoding = { "uts-16" }
				lspconfig.clangd.setup({
					on_attach = on_attach,
					capabilities = capabilities_cpp,
				})
			end,

			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = { -- custom settings for lua
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								-- make language server aware of runtime files
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.stdpath("config") .. "/lua"] = true,
								},
							},
						},
					},
				})
			end,
		})
		typescript.setup({
			server = {
				capabilities = capabilities,
				on_attach = on_attach,
			},
		})
	end,
}
