return {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",

    version = "*",

    opts = {
        keymap = {
            preset = "default",
            ['<Tab>'] = { 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
            ['<CR>'] = { 'select_and_accept', 'fallback' },
        },

        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono"
        },

        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 200 },
        },

        sources = {
            default = { "lsp", "path", "snippets" },
        },
        cmdline = {
            enabled = false,
        }
    },
    opts_extend = { "sources.default" }
}
