local utils = require("utils")

return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "lua_ls", "rust_analyzer", "robotframework_ls", "bashls" }
            })
        end,
        dependencies = { "mason.nvim" },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- clangd config
            lspconfig.clangd.setup({
                capabilities = capabilities,
                on_init = function(_)
                    vim.keymap.set("n", "<M-o>", "<cmd>ClangdSwitchSourceHeader<CR>",
                        utils.keymap_opts("Switch between source/header"))
                end
            })

            -- lua_ls config
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime = {
                            version = "LuaJIT"
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                                "${3rd}/luv/library"
                            }
                        }
                    })
                end,
                settings = {
                    Lua = {}
                }
            })

            -- pyright config
            lspconfig.pyright.setup({})

            -- gopls config
            lspconfig.gopls.setup({})

            -- bashls config
            lspconfig.bashls.setup({})

            -- robot framework config
            lspconfig.robotframework_ls.setup({})

            -- set keymaps on attach
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>",
                        utils.keymap_opts("Displays hover information", event.buf))
                    vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<cr>",
                        utils.keymap_opts("Displays diagnostic in float window", event.buf))
                    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>",
                        utils.keymap_opts("Jumps to the definition of the symbol", event.buf))
                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>",
                        utils.keymap_opts("Jumps to the declaration of the symbol", event.buf))
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>",
                        utils.keymap_opts("Lists all the implementations for the symbol", event.buf))
                    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>",
                        utils.keymap_opts("Jumps to the definition of the type of the symbol", event.buf))
                    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>",
                        utils.keymap_opts("Lists all the references to the symbol", event.buf))
                    vim.keymap.set("n", "gK", "<cmd>lua vim.lsp.buf.signature_help()<cr>",
                        utils.keymap_opts("Displays signature information about the symbol", event.buf))
                    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>",
                        utils.keymap_opts("Renames all references to the symbol", event.buf))
                    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
                        utils.keymap_opts("Formats a buffer", event.buf))
                    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>",
                        utils.keymap_opts("Selects a code action available at the current cursor position", event.buf))
                end,
            })

            vim.diagnostic.config({
                virtual_text = true,
            })
        end
    },
}
