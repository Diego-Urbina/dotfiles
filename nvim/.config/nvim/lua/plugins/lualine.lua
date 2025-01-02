return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = "catppuccin"
            },
            sections = {
                lualine_b = {
                    {
                        "branch",
                        fmt = function(str)
                            local max = math.min(30, string.len(str))
                            return str:sub(1, max)
                        end
                    },
                    {"diff"},
                    {"diagnostics"}
                },
                lualine_c = {
                    {
                        "filename", path = 1
                    }
                },
            }
        })
    end
}
