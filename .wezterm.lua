-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 13
config.color_scheme = "carbonfox"
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.term = "xterm-256color"
config.window_background_opacity = 0.75
config.macos_window_background_blur = 50
config.max_fps = 60

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- and finally, return the configuration to wezterm
return config
