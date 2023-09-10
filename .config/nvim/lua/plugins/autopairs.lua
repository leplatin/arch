return {
	"windwp/nvim-autopairs",
	lazy = false,
	config = function()
		require("nvim-autopairs").setup({
			check_ts = true, -- enable treesitter
			ts_config = {
				lua = { "string" }, -- don't add pairs in lua string treesitter nodes
				javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
				java = false, -- don't check treesitter on java
			},
		})
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp_status_ok, cmp = pcall(require, "cmp")
		if not cmp_status_ok then
			return
		end
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
