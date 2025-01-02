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
                        -- format function to truncate branch's name to 30 characters
                        fmt = function(str)
                            local max_len = 30
                            local l = string.len(str)
                            if l > max_len then
                               return str:sub(1, max_len) .. "..."
                            end
                            return str
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
