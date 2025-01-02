return {
    {
        "echasnovski/mini.cursorword",
        version = "*",
        config = function()
            require("mini.cursorword").setup()
            --vim.cmd("hi! link MiniCursorword Visual")
            --vim.cmd("hi! MiniCursorwordCurrent gui=nocombine guifg=NONE guibg=NONE")
        end
    },
    {
        'fei6409/log-highlight.nvim',
        config = true,
    }
}
