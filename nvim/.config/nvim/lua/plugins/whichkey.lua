local utils = require("utils")

return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "modern"
    },
    config = function()
        local wk = require("which-key")

        vim.keymap.set("n", "<leader>?",
            function()
                wk.show({ global = false })
            end,
            utils.keymap_opts("Buffer Local Keymaps (which-key)"))

        wk.add({
            { "<leader>f", group = "Find" },
            { "<leader>t", group = "Toggle" },
            { "<leader>g", group = "Git" },
        })
    end
}
