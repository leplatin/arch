return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufNewFile", "BufReadPost", "BufWritePost" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-refactor",
		"HiPhish/nvim-ts-rainbow2",
	},
	config = function()
		-- Folding
		vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
		vim.o.foldcolumn = "auto"
		vim.o.foldexpr = "nvim_treesitter#foldexpr()"
		vim.o.foldlevel = 99
		vim.o.foldmethod = "expr"
		vim.o.foldminlines = 1
		vim.o.foldnestmax = 3
		vim.o.foldtext = "v:lua.custom_fold_text()"

		function custom_fold_text()
			local line_count = vim.v.foldend - vim.v.foldstart + 1
			local foldstart = vim.fn.getline(vim.v.foldstart):gsub("\t", " ")

			if foldstart:find("^%s") ~= nil then
				-- line start with space, replace spaces with formatted text
				local offset = string.len(string.match(foldstart, "^%s+")) - 3 -- leading spaces minus icon and surrounding spaces
				local leading_text = string.format("  %s ", string.rep("-", offset))
				foldstart = foldstart:gsub("^%s+", leading_text) -- replace spaces with icon and dashes
			end

			return string.format("%s  󰦸 (%s lines)", foldstart, line_count)
		end

		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
				additional_vim_regex_highlighting = false,
			},
			autopairs = { enable = true },
			autotag = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"scss",
				"markdown",
				"markdown_inline",
				"bash",
				"lua",
				"vim",
				-- "svelte",
				-- "graphql",
				-- "dockerfile",
				-- "gitignore",
				-- "c",
				-- "cpp",
				-- "c_sharp",
				-- "go",
				-- "rust",
				-- "markdown",
				-- "python",
				-- "vue",
				-- "ini",
			},
			sync_install = true,
			ignore_install = {}, -- List of parsers to ignore installation
			refactor = {
				highlight_definitions = {
					enable = true,
					-- Set to false if you have an `updatetime` of ~100.
					clear_on_cursor_move = true,
				},
				highlight_current_scope = { enable = false },
			},
			rainbow = {
				enable = true,
				disable = { "jsx", "cpp" },
				query = {
					"rainbow-parens",
					html = "rainbow-tags",
					latex = "rainbow-blocks",
				},
				strategy = require("ts-rainbow").strategy.global,
			},
		})
	end,
}
