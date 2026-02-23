-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.window_decorations = "RESIZE"
config.term = "xterm-256color"

-- This is where you actually apply your config choices.
config.font = wezterm.font("PragmataPro Mono Liga", { weight = "Medium" })
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
		}),
	},
	{
		key = "s",
		mods = "SHIFT|CTRL",
		action = wezterm.action.SplitVertical({
			args = {},
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


--config.enable_tab_bar = false
config.tab_bar_at_bottom = true
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
	sections = {
		tabline_a = "",
		tabline_b = "",
		tabline_c = "",
		tab_active = {
            {"index", padding = {left = 0, right = 1}},
            { "process", padding = { left = 0, right = 1 } },
            { "zoomed", padding = {left =0, right=0} }

        },
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		-- All other sections are omitted or left empty
		tabline_x = { "" },
		tabline_y = { "" },
		tabline_z = { "domain" },
	},
	options = {
		icons_enabled = true,
		theme = "GruvboxDarkHard",
		tabs_enabled = true,
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
	},
})
tabline.apply_to_config(config)

-- Finally, return the configuration to wezterm:
return config
