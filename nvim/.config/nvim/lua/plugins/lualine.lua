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
                        "filename", path = 1
                    },
                    {
                        function()
                            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                                if vim.api.nvim_get_option_value("modified", { buf = buf }) then
                                    return "🔵"
                                end
                            end
                            return ""
                        end
                    },
                },
                lualine_c = {
                    { "diagnostics" }
                },
                lualine_x = {
                    {
                        "branch",
                        fmt = function(str)
                            local max = math.min(30, string.len(str))
                            return str:sub(1, max)
                        end
                    },
                },
                lualine_y = {
                    { "filetype" },
                    { 'progress' }
                },
            }
        })
    end
}
