local utils = require("utils")

local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function edit_or_open()
        local node = api.tree.get_node_under_cursor()

        if node.nodes ~= nil then
            -- expand or collapse folder
            api.node.open.edit()
        else
            -- open file
            api.node.open.edit()
            -- Close the tree if file was opened
            api.tree.close()
        end
    end

    local function close_folder()
        local node = api.tree.get_node_under_cursor()
        api.node.navigate.parent_close(node)
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "?", api.tree.toggle_help, utils.keymap_opts("Help", bufnr))
    vim.keymap.set("n", "l", edit_or_open, utils.keymap_opts("Edit Or Open", bufnr))
    vim.keymap.set("n", "h", close_folder, utils.keymap_opts("Close", bufnr))
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
                width = "40%",
                side = "right",
            },
            renderer = {
                group_empty = true, -- Compact folders with only one folder inside
            },
            filters = {
                dotfiles = false,
                git_ignored = false,
                custom = { "^\\.git", "^\\.cache" }
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
            hijack_cursor = true,
            on_attach = my_on_attach,

            vim.keymap.set("n", "<leader>m", ":NvimTreeFindFileToggle<CR>", utils.keymap_opts("Toogle file tree"))
        })
    end,
}
