--local Util = require("lazyvim.util")

return {
	"nvim-telescope/telescope.nvim",
	event = "BufReadPre",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
	keys = {

		{ "<C-M-o>", "<cmd>lua require('telescope.builtin').find_files()<cr>" },
		{
			"<C-M-p>",
			"<cmd>lua require('telescope.builtin').builtin(require('telescope.themes').get_dropdown({}))<cr>",
		},
		--{ "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
		{ "<C-g>", "<cmd>lua require('telescope.builtin').live_grep()<cr>" },
		{ "<C-f>", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>" },
		{ "<leader>ff", "<cmd>Telescope find_files<cr>" }, -- find files within current working directory, respects .gitignore
		{ "<leader>fs", "<cmd>Telescope live_grep<cr>" }, -- find string in current working directory as you type
		{ "<leader>fc", "<cmd>Telescope grep_string<cr>" }, -- find string under cursor in current working directory
		{ "<leader>fb", "<cmd>Telescope buffers<cr>" }, -- list open buffers in current neovim instance
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>" }, -- list available help tags
		-- telescope git commands
		{ "<leader>gc", "<cmd>Telescope git_commits<cr>" }, -- list all git commits (use <cr> to checkout) ["gc" for git commits]
		{ "<leader>gfc", "<cmd>Telescope git_bcommits<cr>" }, -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
		{ "<leader>gb", "<cmd>Telescope git_branches<cr>" }, -- list git branches (use <cr> to checkout) ["gb" for git branch]
		{ "<leader>gs", "<cmd>Telescope git_status<cr>" }, -- list current changes per file with diff preview ["gs" for git status]
	},
	opts = function()
		local actions = require("telescope.actions")
		local theme = require("telescope.themes")
		return {
			pickers = {
				find_files = { hidden = true },
				live_grep = {
					additional_args = function(opts)
						return { "--hidden" }
					end,
				},
			},
			defaults = {
				mappings = { i = { ["<esc>"] = actions.close } },
			},

			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
				["ui-select"] = {
					theme.get_dropdown({
						-- even more opts
					}),
				},
			},
		}
	end,
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
	end,
}
