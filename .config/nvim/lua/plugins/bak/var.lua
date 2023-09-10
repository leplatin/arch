return {
	-- maximizes and restores current window
	{ "szw/vim-maximizer", keys = { "<leader>sm", "<cmd>MaximizerToggle<cr>" }, lazy = false },

	-- tmux & split window navigation
	{ "christoomey/vim-tmux-navigator" },

	-- add, delete, change surroundings (for example, ysw" to surround word with " or ds" to delete ")
	{ "tpope/vim-surround", lazy = false },

	-- replace with register contents using motion (gr + motion)
	{ "inkarkat/vim-ReplaceWithRegister" },

	-- commenting with gcc - comment one line; gc3j - comment 3 lines
	{
		"numToStr/Comment.nvim",
		lazy = false,
		keys = {
			{
				"<C-_>",
				mode = "n",
				"<Plug>(comment_toggle_linewise_current)",
			},
			{
				"<C-_>",
				mode = "x",
				"<Plug>(comment_toggle_linewise_visual)",
			},
			{
				"<C-M-_>",
				mode = "n",
				"<Plug>(comment_toggle_blockwise_current)",
			},
			{
				"<C-M-_>",
				mode = "x",
				"<Plug>(comment_toggle_blockwise_visual)",
			},
			{
				"<C-/>",
				mode = "n",
				"<Plug>(comment_toggle_linewise_current)",
			},
			{
				"<C-/>",
				mode = "x",
				"<Plug>(comment_toggle_linewise_visual)",
			},
			{
				"<C-M-/>",
				mode = "n",
				"<Plug>(comment_toggle_blockwise_current)",
			},
			{
				"<C-M-/>",
				mode = "x",
				"<Plug>(comment_toggle_blockwise_visual)",
			},
		},
		opts = {
			mappings = {
				basic = false,
				extra = false,
			},
		},
		config = function()
			require("Comment").setup({})
		end,
	},
}
