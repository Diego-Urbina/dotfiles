return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    enabled = true,
    config = function()
        local treesitter = require("nvim-treesitter")
        local parsers = {
            "vimdoc", "c", "lua", "rust", "bash", "cpp",
        }

        treesitter.setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        vim.treesitter.language.register("vimdoc", "help")

        vim.api.nvim_create_autocmd("FileType", {
            desc = "Start Treesitter highlighting for configured filetypes",
            pattern = { "c", "cpp", "lua", "rust", "bash", "sh", "help" },
            callback = function(event)
                vim.treesitter.start(event.buf)
            end,
        })

        if vim.fn.executable("tree-sitter") == 1 then
            treesitter.install(parsers)
        end
    end,
}
