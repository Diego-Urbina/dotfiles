-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.enable_wayland = true
config.unix_domains = {
  {
    name = 'unix',
    connect_automatically = false,
  },
}

config.color_scheme = 'Catppuccin Macchiato'

config.font = wezterm.font("JetBrains Mono NL")
config.font_size = 10
config.warn_about_missing_glyphs = false
config.adjust_window_size_when_changing_font_size = false
config.audible_bell = "Disabled"

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

config.leader = { key = "Space", mods = "SHIFT", timeout_milliseconds = 2000 }

config.keys = {
    {
        -- create new pane on the right
        mods = "CTRL|SHIFT",
        key = "d",
        action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }
    },
    {
        -- create new pane below 
        mods = "CTRL|SHIFT",
        key = "e",
        action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }
    },
    {
        -- close current pane
        mods = "CTRL|SHIFT",
        key = "w",
        action = wezterm.action.CloseCurrentPane { confirm = true }
    },
    {
        -- create new tab
        mods = "CTRL|SHIFT",
        key = "t",
        action = wezterm.action.SpawnTab "CurrentPaneDomain",
    },
    {
        -- toogle zoom in current pane
        mods = 'CTRL|SHIFT',
        key = 'z',
        action = wezterm.action.TogglePaneZoomState,
    },
    {
        -- focus left pane
        mods = "CTRL",
        key = "h",
        action = wezterm.action.ActivatePaneDirection "Left"
    },
    {
        -- focus down pane
        mods = "CTRL",
        key = "j",
        action = wezterm.action.ActivatePaneDirection "Down"
    },
    {
        -- focus up pane
        mods = "CTRL",
        key = "k",
        action = wezterm.action.ActivatePaneDirection "Up"
    },
    {
        -- focus right pane
        mods = "CTRL",
        key = "l",
        action = wezterm.action.ActivatePaneDirection "Right"
    },
    {
        -- focus prev tab
        mods = "LEADER",
        key = ",",
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        -- focus next tab
        mods = "LEADER",
        key = ".",
        action = wezterm.action.ActivateTabRelative(1)
    },
    {
        -- rename tab
        mods = "LEADER",
        key = "r",
        action = wezterm.action.PromptInputLine {
            description = "Enter new name for tab",
            action = wezterm.action_callback(function(window, _, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        },
    },
    {
        -- resize current pane to left
        mods = "CTRL|SHIFT",
        key = "h",
        action = wezterm.action.AdjustPaneSize { "Left", 5 }
    },
    {
        -- resize current pane to right
        mods = "CTRL|SHIFT",
        key = "l",
        action = wezterm.action.AdjustPaneSize { "Right", 5 }
    },
    {
        -- resize current pane to down
        mods = "CTRL|SHIFT",
        key = "j",
        action = wezterm.action.AdjustPaneSize { "Down", 1 }
    },
    {
        -- resize current pane to up
        mods = "CTRL|SHIFT",
        key = "k",
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
config.tab_max_width = 50
config.show_tab_index_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = false

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
