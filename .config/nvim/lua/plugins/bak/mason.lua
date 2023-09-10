return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	opts = {
		pip = {
			upgrade_pip = true,
		},
		ui = {
			border = "rounded",
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
	config = function(_, opts)
		require("mason").setup(opts)
		local mr = require("mason-registry")
		local packages = {
			"bash-language-server",
			"yaml-language-server",
			"clang-format",
			"clangd",
			"cspell",
			"eslint-lsp",
			"css-lsp",
			"html-lsp",
			"json-lsp",
			"lua-language-server",
			"prettier",
			"pyright",
			"shfmt",
			"stylua",
			"black",
			--    "tailwindcss-language-server",
			--    "taplo",
			--    "typescript-language-server",
			--    "graphql-language-service-cli",
			--    "gopls",
			--    "editorconfig-checker",
			--    "markdownlint",
		}
		for _, package in ipairs(packages) do
			local p = mr.get_package(package)
			if not p:is_installed() then
				p:install()
			end
		end
	end,
}
