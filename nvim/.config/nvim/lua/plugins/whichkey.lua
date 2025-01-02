local utils = require("utils")

return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "modern"
    },
    config = function()
        vim.keymap.set("n", "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            utils.keymap_opts("Buffer Local Keymaps (which-key)"))
    end
}
