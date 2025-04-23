local colors = require("colors")
local settings = require("settings")

-- Equivalent to the --bar domain
sbar.bar({
	color = colors.bar.bg,
	height = settings.height,
	padding_right = 6,
	padding_left = 6,
	corner_radius = 0,
	margin = 0,
	sticky = "on",
	topmost = "window",
	y_offset = -6,
})
