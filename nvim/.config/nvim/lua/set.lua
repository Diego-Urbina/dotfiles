vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

vim.opt.termguicolors = true

vim.opt.clipboard = "unnamedplus"

vim.opt.nu = true
vim.opt.relativenumber = false
vim.opt.cursorline = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.scrolloff = 999
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufRead", {
    desc = "Open trouble instead of quickfix list",
    group = vim.api.nvim_create_augroup("quickfix-to-trouble", { clear = true }),
    callback = function(ev)
        if vim.bo[ev.buf].buftype == "quickfix" then
            vim.schedule(function()
                vim.cmd([[cclose]])
                vim.cmd([[Trouble qflist open]])
            end)
        end
    end,
})

