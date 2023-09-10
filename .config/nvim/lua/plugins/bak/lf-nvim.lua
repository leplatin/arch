return {
  "lmburns/lf.nvim",
  cmd = "Lf",
  dependencies = { "nvim-lua/plenary.nvim", "akinsho/toggleterm.nvim" },
  opts = {
    winblend = 0,
    highlights = { NormalFloat = { guibg = "NONE" } },
    border = "rounded",
    escape_quit = true,
  },
  keys = {
    { "<leader>ll", "<cmd>Lf<cr>", desc = "NeoTree" },
  },
}
