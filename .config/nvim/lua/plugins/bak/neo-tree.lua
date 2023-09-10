return {
	"nvim-neo-tree/neo-tree.nvim",
	lazy = true,
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	keys = { { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" } },
	config = function()
		require("neo-tree").setup({
			follow_current_file = true,
			hijack_netrw_behavior = "open_current",
			window = { width = 25 },
			default_component_configs = {
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
					padding = 1,
				},
			},

			-- hide cursor, doesn't work for some reason
			event_handlers = {
				{
					event = "neo_tree_buffer_enter",
					handler = function()
						-- This effectively hides the cursor
						vim.cmd([[highlight! Cursor blend=100]])
					end,
				},
				{
					event = "neo_tree_buffer_leave",
					handler = function()
						-- Make this whatever your current Cursor highlight group is.
						vim.cmd([[highlight! Cursor guibg=#24273A blend=0]])
					end,
				},
			},
		})
	end,
}
