local colors = require("colors")
local icons = require("icons")
local setting = require("settings")

local input_map = {
	["Graphite"] = icons.layout.graphite,
	["U.S."] = icons.layout.qwerty,
}

local layout = sbar.add("item", "keyboardlayout", {
	position = "right",
	icon = {
		string = icons.layout.missing,
		padding_left = 8,
		padding_right = 4,
		y_offset = -2,
	},
	label = { drawing = false },
	background = { drawing = false },
})

local function get_layout()
	local source = "?"
	sbar.exec(
		"/usr/bin/defaults read /Users/tim/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources "
			.. "| /usr/bin/grep -w 'KeyboardLayout Name' "
			.. '| /usr/bin/sed -E \'s/^.+ = "?([^"]+)"?;$/\\1/\' '
			.. "| /usr/bin/tr -d '[:space:]'",
		function(curr_layout)
			source = input_map[curr_layout] or "?"
			layout:set({
				icon = { string = source },
			})
		end
	)
	-- local log = io.open("/tmp/sketchybar_debug.log", "a")
	-- log:write("Keyboard layout is: ", source, "\n")
	-- log:close()
end

get_layout()

sbar.add("event", "input_change", "AppleSelectedInputSourcesChangedNotification")

layout:subscribe({ "input_change", "system_woke" }, function()
	get_layout()
end)
