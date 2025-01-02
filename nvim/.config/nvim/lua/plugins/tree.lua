local utils = require("utils")

local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "?", api.tree.toggle_help, utils.keymap_opts("Help", bufnr))
end

return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = "20%",
                side = "right",
            },
            renderer = {
                group_empty = true, -- Compact folders with only one folder inside
            },
            filters = {
                dotfiles = false,
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                    window_picker = {
                        enable = false, -- Open file in last window
                    }
                },
            },
            update_focused_file = {
                enable = true
            },
            modified = {
                enable = true
            },
            on_attach = my_on_attach,

            vim.keymap.set("n", "<leader>m", ":NvimTreeFindFileToggle<CR>", utils.keymap_opts("Toogle file tree"))
        })
    end,
}
