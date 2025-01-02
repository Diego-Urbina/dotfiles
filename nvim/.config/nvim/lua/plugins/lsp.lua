local utils = require("utils")

local servers = { "clangd", "lua_ls", "pyright", "bashls", "robotframework_ls" }

local function clangd_switch_source_header(bufnr, client)
    local method_name = "textDocument/switchSourceHeader"

    if not client or not client:supports_method(method_name) then
        vim.notify(("method %s is not supported by any servers active on the current buffer"):format(method_name))
        return
    end

    local params = vim.lsp.util.make_text_document_params(bufnr)
    client:request(method_name, params, function(err, result)
        if err then
            error(tostring(err))
        end

        if not result then
            vim.notify("corresponding file cannot be determined")
            return
        end

        vim.cmd.edit(vim.uri_to_fname(result))
    end, bufnr)
end

local function configure_servers(capabilities)
    local uv = vim.uv or vim.loop

    vim.lsp.config("*", {
        capabilities = capabilities,
    })

    vim.lsp.config("clangd", {
        cmd = { "docker", "exec", "-i", "wbx_developer_supernova", "/home/user/.vscode-server/data/User/globalStorage/llvm-vs-code-extensions.vscode-clangd/install/22.1.0/clangd_22.1.0/bin/clangd", "--path-mappings=/mnt/data/src/wallbox_sw=/home/user/wbx", "--query-driver=/usr/bin/g++", "--clang-tidy" },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        root_markers = {
            ".clangd",
            ".clang-tidy",
            ".clang-format",
            "compile_commands.json",
            "compile_flags.txt",
            "configure.ac",
            ".git",
        },
        capabilities = {
            textDocument = {
                completion = {
                    editsNearCursor = true,
                },
            },
            offsetEncoding = { "utf-8", "utf-16" },
        },
        on_init = function(client, init_result)
            if init_result and init_result.offsetEncoding then
                client.offset_encoding = init_result.offsetEncoding
            end
        end,
        on_attach = function(client, bufnr)
            vim.api.nvim_buf_create_user_command(bufnr, "LspClangdSwitchSourceHeader", function()
                clangd_switch_source_header(bufnr, client)
            end, { desc = "Switch between source/header" })

            vim.keymap.set("n", "<M-o>", "<cmd>LspClangdSwitchSourceHeader<CR>",
                utils.keymap_opts("Switch between source/header", bufnr))
        end,
    })

    vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = {
            ".emmyrc.json",
            ".luarc.json",
            ".luarc.jsonc",
            ".luacheckrc",
            ".stylua.toml",
            "stylua.toml",
            "selene.toml",
            "selene.yml",
            ".git",
        },
        on_init = function(client)
            local workspace = client.workspace_folders and client.workspace_folders[1]
            local path = workspace and workspace.name
            local has_local_config = path and (uv.fs_stat(path .. "/.luarc.json") or uv.fs_stat(path .. "/.luarc.jsonc"))

            if has_local_config then
                return
            end

            client.config.settings = client.config.settings or {}
            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
                runtime = {
                    version = "LuaJIT",
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                        "${3rd}/luv/library",
                    },
                },
            })
        end,
        settings = {
            Lua = {
                codeLens = { enable = true },
                hint = { enable = true, semicolon = "Disable" },
            },
        },
    })

    vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = {
            "pyrightconfig.json",
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
            ".git",
        },
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "openFilesOnly",
                },
            },
        },
    })

    vim.lsp.config("bashls", {
        cmd = { "bash-language-server", "start" },
        filetypes = { "bash", "sh" },
        root_markers = { ".git" },
        settings = {
            bashIde = {
                globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
            },
        },
    })

    vim.lsp.config("robotframework_ls", {
        cmd = { "robotframework_ls" },
        filetypes = { "robot" },
        root_markers = { "robotidy.toml", "pyproject.toml", "conda.yaml", "robot.yaml", ".git" },
    })
end

local function set_lsp_keymaps(event)
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
end

return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim", "saghen/blink.cmp" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "rust_analyzer", "robotframework_ls", "bashls", "pyright" }
            })
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            configure_servers(capabilities)

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = set_lsp_keymaps,
            })

            vim.diagnostic.config({
                virtual_text = true,
            })

            for _, server in ipairs(servers) do
                vim.lsp.enable(server)
            end
        end
    },
}
