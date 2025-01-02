local utils = require("utils")

return
{
    {
        "f-person/git-blame.nvim",
        event = "VeryLazy",
        opts = { date_format = "%d-%m-%Y %H:%M:%S" }
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup({
                on_attach = function(bufnr)
                    local gitsigns = require("gitsigns")

                    vim.keymap.set("n", "]c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "]c", bang = true })
                        else
                            gitsigns.nav_hunk("next")
                        end
                    end, utils.keymap_opts("Prev hunk", bufnr))

                    vim.keymap.set("n", "[c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "[c", bang = true })
                        else
                            gitsigns.nav_hunk("prev")
                        end
                    end, utils.keymap_opts("Next hunk", bufnr))

                    vim.keymap.set("n", "<leader>ga", gitsigns.stage_hunk, utils.keymap_opts("Toggle stage hunk", bufnr))
                    vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, utils.keymap_opts("Reset hunk", bufnr))
                    vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, utils.keymap_opts("Preview hunk", bufnr))
                end
            })
        end
    },
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
        config = function()
            require("diffview").setup({
                file_panel = {
                    win_config = {
                        position = "right"
                    }
                }
            })

            vim.keymap.set("n", "<leader>gd", function()
                if next(require("diffview.lib").views) == nil then
                    vim.cmd("DiffviewOpen")
                else
                    vim.cmd("DiffviewClose")
                end
            end, utils.keymap_opts("Toggle git diff"))
        end
    }
}
