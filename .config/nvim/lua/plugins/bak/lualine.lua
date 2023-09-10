return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = function()
		-- local custom_colors = require("utils.custom_lualine_colors")
		local C = require("catppuccin.palettes").get_palette()
		local O = require("catppuccin").options
		local transparent_bg = O.transparent_background and "NONE" or C.surface0
		local catppuccin_colors = {
			normal = {
				a = { bg = C.blue, fg = C.mantle, gui = "bold" },
				b = { bg = C.surface1, fg = C.blue },
				c = { bg = C.surface0, fg = C.text },
			},
			insert = {
				a = { bg = C.green, fg = C.base, gui = "bold" },
				b = { bg = C.surface1, fg = C.teal },
			},
			terminal = {
				a = { bg = C.green, fg = C.base, gui = "bold" },
				b = { bg = C.surface1, fg = C.teal },
			},
			command = {
				a = { bg = C.peach, fg = C.base, gui = "bold" },
				b = { bg = C.surface1, fg = C.peach },
			},
			visual = {
				a = { bg = C.mauve, fg = C.base, gui = "bold" },
				b = { bg = C.surface1, fg = C.mauve },
			},
			replace = {
				a = { bg = C.red, fg = C.base, gui = "bold" },
				b = { bg = C.surface1, fg = C.red },
			},
			inactive = {
				a = { bg = transparent_bg, fg = C.blue },
				b = { bg = transparent_bg, fg = C.surface1, gui = "bold" },
				c = { bg = transparent_bg, fg = C.overlay0 },
			},
		}

		require("lualine").setup({
			options = {
				icons_enabled = false,
				theme = catppuccin_colors,
				component_separators = "|",
				section_separators = "",
			},
		})
	end,
}
