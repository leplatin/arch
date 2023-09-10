return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"mfussenegger/nvim-dap",
		plugin = true,
		keys = {
			{ mode = "n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>" },
		},
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		keys = {
			{ mode = "n", "<leader>dr", "<cmd>lua require('dap-python').test_method()<cr>" },
		},
		config = function(_, opts)
			local path = "~/local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
		end,
	},
}
