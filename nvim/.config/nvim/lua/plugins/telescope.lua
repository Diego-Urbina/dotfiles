local utils = require("utils")

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
        require("telescope").setup({
            defaults = {
                path_display = function(_, path)
                    local tail = require("telescope.utils").path_tail(path)
                    return string.format("%s (%s)", tail, path)
                end,
                layout_strategy = 'vertical',
                layout_config = {
                    width = 0.95,
                    height = 0.95,
                    vertical = {
                        preview_height = 0.6
                    },
                },
            },
            pickers = {
                buffers = {
                    initial_mode = "normal",
                    sort_mru = true,
                }
            },
            extensions = {
                fzf = {}
            }
        })

        require("telescope").load_extension("fzf")

        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>ff", builtin.find_files, utils.keymap_opts("Find files"))
        vim.keymap.set("n", "<leader>fo", function() builtin.oldfiles({ only_cwd = true }) end,
            utils.keymap_opts("Find old files"))
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, utils.keymap_opts("Search for a string"))
        vim.keymap.set("n", "<leader>fs", builtin.grep_string, utils.keymap_opts("Search for string under cursor"))
        vim.keymap.set("n", "<leader>fb", builtin.buffers, utils.keymap_opts("Find buffers"))
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, utils.keymap_opts("Search help"))
        vim.keymap.set("n", "<leader>fl", builtin.resume, utils.keymap_opts("Open last picker"))
        vim.keymap.set("n", "<leader>fr", builtin.lsp_references, utils.keymap_opts("Find LSP references"))
        vim.keymap.set("n", "<leader>fm",
            function() builtin.lsp_document_symbols({ symbols = { "method", "function" }, symbol_width = 200 }) end,
            utils.keymap_opts("Find functions"))
        vim.keymap.set("n", "<leader>gs", builtin.git_status, utils.keymap_opts("Git status"))
        vim.keymap.set("n", "<leader>gl", builtin.git_stash, utils.keymap_opts("Git stash list"))
    end,
}
