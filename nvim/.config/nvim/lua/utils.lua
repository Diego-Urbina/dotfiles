local utils = {}

function utils.keymap_opts(desc, bufnr)
    return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

return utils
