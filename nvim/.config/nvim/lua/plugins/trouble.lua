return {
    "folke/trouble.nvim",
    opts = {
        modes = {
            symbols = {
                auto_preview = false,
                focus = true,
                follow = true,
                multiline = false,
                win = { position = "right", size = 80, },
            }
        },
        keys = {
            ["<cr>"] = "jump_close"
        }
    },
    cmd = "Trouble",
    keys = {
        { "<leader>tD", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
        { "<leader>td", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
        { "<leader>tl", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location List (Trouble)" },
        { "<leader>tq", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix List (Trouble)" },
        { "<leader>ts", "<cmd>Trouble symbols toggle<cr>",                  desc = "LSP symbols" },
        {
            "[q",
            function()
                if require("trouble").is_open() then
                    require("trouble").prev({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cprev)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = "Previous Trouble/Quickfix Item",
        },
        {
            "]q",
            function()
                if require("trouble").is_open() then
                    require("trouble").next({ skip_groups = true, jump = true })
                else
                    local ok, err = pcall(vim.cmd.cnext)
                    if not ok then
                        vim.notify(err, vim.log.levels.ERROR)
                    end
                end
            end,
            desc = "Next Trouble/Quickfix Item",
        },
    },
}
