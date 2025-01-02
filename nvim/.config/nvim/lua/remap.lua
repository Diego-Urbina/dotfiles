local utils = require("utils")

vim.g.mapleader = " "

vim.keymap.set("n", "<Space>", "<NOP>")

vim.keymap.set("n", "<C-h>", "<C-w>h", utils.keymap_opts("Focus left window"))
vim.keymap.set("n", "<C-j>", "<C-w>j", utils.keymap_opts("Focus down window"))
vim.keymap.set("n", "<C-k>", "<C-w>k", utils.keymap_opts("Focus up window"))
vim.keymap.set("n", "<C-l>", "<C-w>l", utils.keymap_opts("Focus right window"))

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", utils.keymap_opts("Move line up"))
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", utils.keymap_opts("Move line down"))
