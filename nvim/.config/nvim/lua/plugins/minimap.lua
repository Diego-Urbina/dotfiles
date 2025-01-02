local utils = require("utils")

return {
    "echasnovski/mini.map",
    version = '*',
    dependencies = {
        "lewis6991/gitsigns.nvim"
    },
    config = function()
        local map = require("mini.map")
        map.setup({
            integrations = {
                map.gen_integration.diagnostic(),
                map.gen_integration.gitsigns(),
            },
            window = {
                show_integration_count = false,
            },
        })

        vim.keymap.set("n", "<leader>tm",
            "<cmd>lua MiniMap.toggle()<CR>",
            utils.keymap_opts("Minimap"))
    end
}
