local utils = require("utils")

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
        require("telescope").setup({
            pickers = {
                find_files = {
                    hidden = true,
                    file_ignore_patterns = { ".git/" },
                },
                live_grep = {
                    additional_args = function(_)
                        return { "--hidden" }
                    end,
                    file_ignore_patterns = { ".git/" },
                },
                grep_string = {
                    additional_args = function(_)
                        return { "--hidden" }
                    end,
                    file_ignore_patterns = { ".git/" },

                }
            },
            extensions = {
                fzf = {}
            }
        })

        require("telescope").load_extension("fzf")

        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>ff", builtin.find_files, utils.keymap_opts("Find files"))
        vim.keymap.set("n", "<leader>fr", function() builtin.oldfiles({ only_cwd = true }) end,
            utils.keymap_opts("Find recent files"))
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, utils.keymap_opts("Search for a string"))
        vim.keymap.set("n", "<leader>fs", builtin.grep_string, utils.keymap_opts("Search for string under cursor"))
        vim.keymap.set("n", "<leader>fb", builtin.buffers, utils.keymap_opts("Find buffers"))
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, utils.keymap_opts("Search help"))
        vim.keymap.set("n", "<leader>fl", builtin.resume, utils.keymap_opts("Open last picker"))
        vim.keymap.set("n", "<leader>fm",
            function() builtin.lsp_document_symbols({ symbols = { "method", "function" }, symbol_width = 50 }) end,
            utils.keymap_opts("Find functions"))
    end,
}
