return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	keys = {
		{
			"<leader>zz",
			function()
				require("notify").dismiss({ silent = true, pending = true })
			end,
			desc = "Delete all Notifications",
		},
	},
	opts = {
		timeout = 2000,
		fps = 60,
		background_colour = "#000000",
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
	},
}
