return {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',

    version = '*',

    opts = {
        -- <C-y> to accept, <C-p> and <C-n> to move
        keymap = { preset = 'default' },

        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono'
        },

        sources = {
            default = { 'lsp', 'path', 'snippets'},
            cmdline = {}
        },
    },
    opts_extend = { "sources.default" }
}
