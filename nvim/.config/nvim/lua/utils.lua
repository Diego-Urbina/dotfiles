local utils = {}

function utils.keymap_opts(desc, bufnr)
    return { desc = desc, buffer = bufnr, remap = false, silent = true, nowait = true }
end

return utils
