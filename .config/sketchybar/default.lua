local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
	background = {
		border_color = colors.accent_bright,
		border_width = 0,
		color = colors.bg1,
		corner_radius = 6,
		height = settings.height - 14,
		image = {
			corner_radius = 9,
			border_color = colors.grey,
			border_width = 1,
		},
		y_offset = -3,
	},
	icon = {
		font = {
			family = settings.font_icon.text,
			style = settings.font_icon.style_map["Bold"],
			size = settings.font_icon.size,
		},
		color = colors.text,
		highlight_color = colors.bg1,
		padding_left = 0,
		padding_right = 0,
		y_offset = -3,
	},
	label = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Semibold"],
			size = settings.font.size,
		},
		color = colors.text,
		padding_left = settings.paddings,
		padding_right = settings.paddings,
		y_offset = -3,
	},
	popup = {
		align = "center",
		background = {
			border_width = 0,
			corner_radius = 6,
			color = colors.popup.bg,
			shadow = { drawing = true },
		},
		blur_radius = 50,
		y_offset = 0,
	},
	padding_left = 3,
	padding_right = 3,
	scroll_texts = true,
	updates = "on",
})
