local utils = require("utils")

-- Remap command key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Terminal colors
vim.opt.termguicolors = true

local options = {
	number = true, -- shows absolute line number on cursor line (when relative number is on)
	relativenumber = true,

	tabstop = 2, -- 4 spaces for tabs (prettier default)
	shiftwidth = 2, -- 4 spaces for indent width
	softtabstop = 2,
	numberwidth = 4,
	expandtab = true, -- expand tab to spaces

	-- hide statusline by setting laststatus and cmdheight to 0
	ls = 3, -- set to 3 for global statusline for splits see link: https://youtu.be/jH5PNvJIa6o
	ch = 0,
	wbr = vim.o.stl, -- set the winbar to the statusline
	stl = " ", --set the statusline to empty whitespace
	showmode = false, --hide vim mode line in the bottom

	--autoindent = true, -- copy indent from current line when starting new one
	smartindent = true,
	wrap = false, -- disable line wrapping
	--colorcolumn = "80",

	-- search settings --
	ignorecase = true, -- ignore case when searching
	smartcase = true, -- if you include mixed case in your search, assumes you want case-sensitive
	hlsearch = false,
	incsearch = true,

	--disable swapfile and shada
	swapfile = false,
	-- shadafile = "NONE",

	sessionoptions = "buffers,curdir,folds,help,tabpages,terminal,globals",

	cursorline = false, -- highlight the current cursor line

	background = "dark", -- colorschemes that can be light or dark will be made dark
	signcolumn = "yes", -- show sign column so that text doesn't shift
	pumheight = 10, -- pop up menu height

	backspace = "indent,eol,start", -- allow backspace on indent, end of line or insert mode start position
	splitright = true, -- split vertical window to the right
	splitbelow = true, -- split horizontal window to the bottom
	splitkeep = "screen", -- prevent splits to jump when opening an edgebar
	scrolloff = 8,
	updatetime = 50,
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

-- clipboard --
vim.opt.clipboard:prepend("unnamedplus") -- use system clipboard as default register
vim.opt.iskeyword:append("-") -- consider string-string as whole word

-- disable built-in plugins
local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

-- Python
vim.g.python3_host_prog = "/opt/local/bin/python3"
