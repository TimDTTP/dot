local icons = require("icons")
local settings = require("settings")

sbar.add("item", {
	default = true,
	icon = {
		padding_left = settings.padding.icon_item.icon.padding_left,
		padding_right = settings.padding.icon_item.icon.padding_right,
		string = icons.apple,
		font = { size = 15 },
		y_offset = -2,
	},
	background = { drawing = false },
	label = { drawing = false },
	click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0",
	subscribe = "logo mouse.clicked window_focus front_app_switched space_change title_change",
})
