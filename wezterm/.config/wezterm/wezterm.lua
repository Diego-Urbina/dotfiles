-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Macchiato'

config.font = wezterm.font("JetBrains Mono NL")
config.font_size = 12

config.adjust_window_size_when_changing_font_size = false

config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 0,
}

config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 1.0,
}

config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
    {
        mods = "CTRL|SHIFT",
        key = "d",
        action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }
    },
    {
        mods = "CTRL|SHIFT",
        key = "e",
        action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }
    },
    {
        mods = "CTRL|SHIFT",
        key = "w",
        action = wezterm.action.CloseCurrentPane { confirm = true }
    },
    {
        mods = "CTRL|SHIFT",
        key = "t",
        action = wezterm.action.SpawnTab "CurrentPaneDomain",
    },
    {
        mods = 'CTRL|SHIFT',
        key = 'z',
        action = wezterm.action.TogglePaneZoomState,
    },
    {
        mods = "CTRL|SHIFT",
        key = "h",
        action = wezterm.action.ActivatePaneDirection "Left"
    },
    {
        mods = "CTRL|SHIFT",
        key = "j",
        action = wezterm.action.ActivatePaneDirection "Down"
    },
    {
        mods = "CTRL|SHIFT",
        key = "k",
        action = wezterm.action.ActivatePaneDirection "Up"
    },
    {
        mods = "CTRL|SHIFT",
        key = "l",
        action = wezterm.action.ActivatePaneDirection "Right"
    },
    {
        mods = "CTRL|SHIFT",
        key = ",",
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        mods = "CTRL|SHIFT",
        key = ".",
        action = wezterm.action.ActivateTabRelative(1)
    },
    {
        mods = "CTRL|SHIFT",
        key = "LeftArrow",
        action = wezterm.action.AdjustPaneSize { "Left", 5 }
    },
    {
        mods = "CTRL|SHIFT",
        key = "RightArrow",
        action = wezterm.action.AdjustPaneSize { "Right", 5 }
    },
    {
        mods = "CTRL|SHIFT",
        key = "DownArrow",
        action = wezterm.action.AdjustPaneSize { "Down", 1 }
    },
    {
        mods = "CTRL|SHIFT",
        key = "UpArrow",
        action = wezterm.action.AdjustPaneSize { "Up", 1 }
    },
}

for i = 1, 9 do
    -- leader + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = wezterm.action.ActivateTab(i - 1),
    })
end

-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false

wezterm.on("update-right-status", function(window, _)
    local text = ""

    if window:leader_is_active() then
        text = "Leader"

    end

    window:set_right_status(wezterm.format {
        { Background = { Color = "#1e2030" } },
        { Foreground = { Color = "#c6a0f6" } },
        { Text = text }
    })
end)

-- and finally, return the configuration to wezterm
return config
