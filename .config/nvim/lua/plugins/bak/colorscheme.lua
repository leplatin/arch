return {
	{ "arcticicestudio/nord-vim" },
	{ "rose-pine/neovim", name = "rose-pine" },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "macchiato",
				},
				transparent_background = false,
				show_end_of_buffer = false, -- show the '~' characters after the end of buffers
				term_colors = false,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
					floats = "transparent", -- style for floating windows
					transparent = true,
				},
				color_overrides = {
					macchiato = {
						-- base = "#24273a",
						-- mantle = "#24273a",
						-- crust = "#24273a",
					},
				},
				custom_highlights = function(C)
					return { TabLineSel = { bg = C.blue } }
				end,
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					neotree = true,
					telescope = true,
					notify = false,
					mini = false,
					bufferline = true,
				},
			})
			vim.cmd([[colorscheme catppuccin]])
			vim.cmd([[hi! Normal ctermbg=none guibg=none]])
			-- vim.api.nvim_set_hl(0, "ColorColumn", { bg = "none" })
		end,
	},
}
