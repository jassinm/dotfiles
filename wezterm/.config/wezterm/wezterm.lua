-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.window_decorations = "RESIZE"
config.term = "xterm-256color"

-- This is where you actually apply your config choices.
config.font = wezterm.font("PragmataPro", { weight = "Medium" })
config.font_size = 17


-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.color_scheme = "GruvboxDarkHard"

config.inactive_pane_hsb = {
	hue = 1.0,
	brightness = 1.0,
	saturation = 1.0,
}

config.keys = {
	-- This will create a new split and run the `top` program inside it
	{
		key = "v",
		mods = "SHIFT|CTRL",
		action = wezterm.action.SplitHorizontal({
			args = {},
            domain = 'CurrentPaneDomain',

		}),
	},
	{
		key = "s",
		mods = "SHIFT|CTRL",
		action = wezterm.action.SplitVertical({
			args = {},
            domain = 'CurrentPaneDomain',
		}),
	},
	{
		key = "h",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "m",
		mods = "SHIFT|CTRL",
		action = wezterm.action.TogglePaneZoomState,
	},
}

config.enable_tab_bar = true
config.tab_bar_at_bottom = true


-- Finally, return the configuration to wezterm:
return config
