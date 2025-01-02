local utils = require("utils")

return {
    "echasnovski/mini.map",
    version = '*',
    config = function()
        local map = require("mini.map")
        map.setup({ integrations = { map.gen_integration.diagnostic() } })

        vim.keymap.set("n", "<leader>tm",
            "<cmd>lua MiniMap.toggle()<CR>",
            utils.keymap_opts("Minimap"))
    end
}
