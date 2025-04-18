local colors = require("colors")
local icons = require("icons")

local popup_width = 250

local volume_icon = sbar.add("item", "widgets.volume", {
	position = "right",
	icon = {
		color = colors.text,
		padding_right = 6,
	},
	label = { drawing = false },
	background = { drawing = false },
	popup = {
		align = "center",
		y_offset = 2,
		background = {
			color = colors.bar.bg,
		},
	},
	padding_right = 8,
})

local volume_slider = sbar.add("slider", popup_width, {
	position = "popup." .. volume_icon.name,
	slider = {
		highlight_color = colors.blue,
		background = {
			height = 12,
			corner_radius = 6,
			color = colors.bar.bg,
			border_color = colors.white,
			border_width = 1,
		},
		knob = {
			string = "􀀁",
			drawing = true,
			color = colors.text,
		},
	},
	background = {
		color = colors.bar.bg,
		height = 2,
		y_offset = -20,
	},
	click_script = 'osascript -e "set volume output volume $PERCENTAGE"',
})

volume_icon:subscribe("volume_change", function(env)
	local icon = icons.volume._0
	local volume = tonumber(env.INFO)
	sbar.exec("SwitchAudioSource -t output -c", function(result)
		if volume > 60 then
			icon = icons.volume._100
		elseif volume > 30 then
			icon = icons.volume._66
		elseif volume > 10 then
			icon = icons.volume._33
		elseif volume > 0 then
			icon = icons.volume._10
		end

		volume_icon:set({ icon = icon })
		volume_slider:set({ slider = { percentage = volume } })
	end)
end)

local function volume_collapse_details()
	local drawing = volume_icon:query().popup.drawing == "on"
	if not drawing then
		return
	end
	volume_icon:set({ popup = { drawing = false } })
	sbar.remove("/volume.device\\.*/")
end

local current_audio_device = "None"
local function volume_toggle_details(env)
	if env.BUTTON == "right" then
		sbar.exec("open /System/Library/PreferencePanes/Sound.prefpane")
		return
	end

	local should_draw = volume_icon:query().popup.drawing == "off"
	if should_draw then
		volume_icon:set({ popup = { drawing = true } })
		sbar.exec("SwitchAudioSource -t output -c", function(result)
			current_audio_device = result:sub(1, -2)
			sbar.exec("SwitchAudioSource -a -t output", function(available)
				local current = current_audio_device
				local color = colors.red
				local counter = 0

				for device in string.gmatch(available, "[^\r\n]+") do
					if current == device then
						color = colors.red
					end
					sbar.add("item", "volume.device." .. counter, {
						position = "popup." .. volume_icon.name,
						width = popup_width,
						align = "center",
						label = { string = device, color = color },
						background = { drawing = false },
						click_script = 'SwitchAudioSource -s "'
							.. device
							.. '" && sketchybar --set /volume.device\\.*/ label.color='
							.. colors.red
							.. " --set $NAME label.color="
							.. colors.red,
					})
					counter = counter + 1
				end
			end)
		end)
	else
		volume_collapse_details()
	end
end

local function volume_scroll(env)
	local delta = env.SCROLL_DELTA
	sbar.exec('osascript -e "set volume output volume (output volume of (get volume settings) + ' .. delta .. ')"')
end

volume_icon:subscribe("mouse.clicked", volume_toggle_details)
volume_icon:subscribe("mouse.exited.global", volume_collapse_details)
volume_icon:subscribe("mouse.scrolled", volume_scroll)

-- sbar.add("bracket", { "widgets.volume" }, {})
