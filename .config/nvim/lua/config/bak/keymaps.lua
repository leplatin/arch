local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap("i", "jk", "<ESC>")

-- use j and k to move string like in VSCODE (in visual mode)
-- keymap("v", "J", ":m '>+1<CR>gv=gv")
-- keymap("v", "K", ":m '<-2<CR>gv=gv")
keymap("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
keymap("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

keymap("x", "<leader>p", [["_dP]])

-- clear search highlights
keymap("n", "<leader>nh", ":nohl<CR>")

-- Clear search results
keymap("n", "<esc>", "<cmd>noh<cr>")

-- delete single character without copying into register
keymap("n", "x", '"_x')

-- increment/decrement numbers
keymap("n", "<leader>+", "<C-a>") -- increment
keymap("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap("n", "<leader>sx", ":close<CR>") -- close current split window

keymap("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Switch buffers with tab
keymap("n", "<S-TAB>", "<CMD>bprevious<CR>")
keymap("n", "<TAB>", "<CMD>bnext<CR>")

-- Better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Save file
keymap({ "i", "v", "n" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Exit neovim
keymap({ "i", "v", "n" }, "<C-q>", "<cmd>q<cr>", { desc = "Exit Vim" })
keymap({ "i", "v", "n" }, "<C-M-q>", "<cmd>qa!<cr>", { desc = "Exit Vim" })

-- Paste without replace clipboard
keymap("v", "p", '"_dP')

-- CLose buffer
--keymap({ "i", "v", "n" }, "<C-w>", "<cmd>bd<cr><esc>", { desc = "Close buffer" })
keymap({ "i", "v", "n" }, "<C-w>", "<cmd>bd!<cr><esc>", { desc = "Close buffer" })

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- lazy
keymap("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- restart lsp server (not on youtube nvim video)
keymap("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary
