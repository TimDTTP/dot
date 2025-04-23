local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local whitelist = {
	["Google Chrome"] = true,
	["Firefox"] = true,
	["Music"] = true,
	["Plexamp"] = true,
	["Safari"] = true,
	["Spotify"] = true,
}

local now_playing = sbar.add("item", {
	position = "e",
	drawing = false,
	background = {
		color = colors.bar.bg,
		drawing = false,
	},
	icon = {
		padding_left = settings.padding.icon_label_item.icon.padding_left,
		padding_right = settings.padding.icon_label_item.icon.padding_right,
		string = "􀙫",
		color = colors.text,
	},
	label = {
		highlight = false,
		max_chars = 40,
		scroll_duration = 200,
		color = colors.text,
		padding_left = settings.padding.icon_label_item.label.padding_left,
		padding_right = settings.padding.icon_label_item.label.padding_right,
	},
	popup = { align = "center" },
})

-- Previous state tracking to detect when media starts playing
local was_playing = false

now_playing:subscribe("media_change", function(env)
	if whitelist[env.INFO.app] then
		local is_playing = (env.INFO.state == "playing")
		local app_color = colors.bar.bg

		-- Check if we're transitioning from not playing to playing
		local started_playing = (not was_playing and is_playing)

		now_playing:set({
			drawing = is_playing,
			label = { string = env.INFO.title .. " [" .. env.INFO.artist .. "]" },
		})

		-- Add animation when media starts playing
		-- if started_playing then
		-- 	-- Animate the item with a subtle fade-in
		-- 	now_playing:animate("sin", 10, function()
		-- 		now_playing:set({
		-- 			background = { color = app_color .. "aa" }, -- Add transparency
		-- 		})
		-- 	end, function()
		-- 		now_playing:set({
		-- 			background = { color = app_color }, -- Back to normal
		-- 		})
		-- 	end)
		-- end

		-- Update the state tracker
		was_playing = is_playing
	end
end)

-- Make sure the item is updated when sketchybar starts
now_playing:subscribe("system_woke", function(env)
	sbar.trigger("media_change")
end)
