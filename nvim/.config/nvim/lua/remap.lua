local utils = require("utils")

vim.g.mapleader = " "

vim.keymap.set("n", "<Space>", "<NOP>")
vim.keymap.set({"n", "i"}, "<Up>", "<NOP>")
vim.keymap.set({"n", "i"}, "<Down>", "<NOP>")
vim.keymap.set({"n", "i"}, "<Left>", "<NOP>")
vim.keymap.set({"n", "i"}, "<Right>", "<NOP>")
vim.keymap.set({ "n", "i", "x" }, "<C-c>", "<ESC>", { remap = true })

-- Windows
vim.keymap.set("n", "<C-h>", "<C-w>h", utils.keymap_opts("Focus left window"))
vim.keymap.set("n", "<C-j>", "<C-w>j", utils.keymap_opts("Focus down window"))
vim.keymap.set("n", "<C-k>", "<C-w>k", utils.keymap_opts("Focus up window"))
vim.keymap.set("n", "<C-l>", "<C-w>l", utils.keymap_opts("Focus right window"))
vim.keymap.set("n", "<C-w>t", "<cmd>tabnew %<CR>", utils.keymap_opts("Open current window in new tab"))
vim.keymap.set("n", "<C-w>x", "<C-w>s", utils.keymap_opts("Split window horizontally"))

-- Editions
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", utils.keymap_opts("Move line dowb"))
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", utils.keymap_opts("Move line up"))
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", utils.keymap_opts("Move line down"))
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", utils.keymap_opts("Move line up"))

-- Motions
vim.keymap.set("n", "_", "0_") -- Go to first non-blank character, but scrolling to first column
vim.keymap.set("n", "^", "0^") -- Same

-- Commands
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Stop the highlighting
vim.keymap.set("n", "<leader>fc", "*N", utils.keymap_opts("Search in current buffer word under cursor"))
