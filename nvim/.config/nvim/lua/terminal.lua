local utils = require("utils")

local state = {
    terminal = {
        buf = -1,
        win = -1,
    }
}

local function get_buffer(opts)
    opts = opts or {}
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    end

    return buf
end

local function create_floating_window(opts)
    opts = opts or {}

    -- Create a buffer
    local buf = get_buffer(opts)

    -- Calculate the size and the position of the window
    local width = opts.width or math.floor(vim.o.columns * 0.9)
    local height = opts.height or math.floor(vim.o.lines * 0.8)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

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

local function create_bottom_window(opts)
    opts = opts or {}

    -- Create a buffer
    local buf = get_buffer(opts)

    -- Create the horizontal split
    local win = vim.api.nvim_open_win(buf, true, {
        height = math.floor(vim.o.lines * 0.3),
        vertical = false,
        win = -1,
    })

    return { buf = buf, win = win }
end

local function get_float_window()
    state.terminal = create_floating_window { buf = state.terminal.buf }
    if vim.bo[state.terminal.buf].buftype ~= "terminal" then
        vim.cmd.terminal()
    end
end

local function get_bottom_window()
    state.terminal = create_bottom_window { buf = state.terminal.buf }
    if vim.bo[state.terminal.buf].buftype ~= "terminal" then
        vim.cmd.terminal()
    end
end

local function toggle_float_terminal()
    if not vim.api.nvim_win_is_valid(state.terminal.win) then
        get_float_window()
    else
        vim.api.nvim_win_hide(state.terminal.win)
    end
end

local function toggle_bottom_terminal()
    if not vim.api.nvim_win_is_valid(state.terminal.win) then
        get_bottom_window()
    else
        vim.api.nvim_win_hide(state.terminal.win)
    end
end

local function run_cmd_in_terminal(cmd)
    if not vim.api.nvim_win_is_valid(state.terminal.win) then
        get_float_window()
    end

    vim.fn.feedkeys("a" .. cmd .. "\n", "t")
end

vim.api.nvim_create_user_command("Floaterminal", toggle_float_terminal, {})
vim.api.nvim_create_user_command("Bottomterminal", toggle_bottom_terminal, {})

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", utils.keymap_opts("Exit terminal mode"))
vim.keymap.set("n", "<leader>tt", "<cmd>Floaterminal<CR>", utils.keymap_opts("Floating terminal"))
vim.keymap.set("n", "<leader>tb", "<cmd>Bottomterminal<CR>", utils.keymap_opts("Bottom terminal"))

-- example of keymap to run a command in the terminal
vim.keymap.set("n", "<F7>", function() run_cmd_in_terminal("ping 8.8.8.8") end, utils.keymap_opts("Compile wallbox_sw"))
