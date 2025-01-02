local utils = require("utils")

local state = {
    floating = {
        buf = -1,
        win = -1,
    }
}

local function create_floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.9)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    -- Calculate the position to center the window
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Create a buffer
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    end

    -- Define window configuration
    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal", -- No borders or extra UI elements
        border = "rounded",
    }

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

local create_win = function()
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
        vim.cmd.terminal()
    end
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        create_win()
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end

local run_cmd_in_terminal = function(cmd)
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        create_win()
    end

    vim.fn.feedkeys("a" .. cmd .. "\n", "t")
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", utils.keymap_opts("Exit terminal mode"))
vim.keymap.set("n", "<leader>tt", "<cmd>Floaterminal<CR>", utils.keymap_opts("Toggle floating terminal"))
-- example of keymap to run a command in the terminal
vim.keymap.set("n", "<F7>", function() run_cmd_in_terminal("ping 8.8.8.8") end, utils.keymap_opts("Compile wallbox_sw"))
