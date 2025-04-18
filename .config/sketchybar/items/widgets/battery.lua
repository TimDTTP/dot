local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Battery indicator item
local battery = sbar.add("item", "widgets.battery", {
	position = "right",
	update_freq = 180,
	icon = {
		font = { size = 14.0 },
		padding_left = settings.padding.icon_label_item.icon.padding_left,
		padding_right = settings.padding.icon_label_item.icon.padding_right,
	},
	background = {
		drawing = false,
	},
})

-- Time remaining popup item
local remaining_time = sbar.add("item", {
	position = "popup." .. battery.name,
	icon = {
		string = "Time remaining:",
		align = "left",
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Regular"],
			size = settings.font.size,
		},
		padding_left = 2,
	},
	label = {
		string = "00:00h",
		align = "right",
		padding_right = 4,
	},
})

-- Battery update function
battery:subscribe({ "routine", "power_source_change", "system_woke" }, function()
	sbar.exec("pmset -g batt", function(batt_info)
		local icon = "!"
		local label = "?"
		local found, _, charge = batt_info:find("(%d+)%%")

		if found then
			charge = tonumber(charge)
			label = charge .. "%"
		end

		local charging, _, _ = batt_info:find("AC Power")

		if charging then
			icon = icons.battery.plug
		else
			icon = icons.battery.bolt
		end

		local lead = ""
		if found and charge < 10 then
			lead = "0"
		end

		battery:set({
			icon = {
				string = icon,
			},
			label = { string = lead .. label },
		})
	end)
end)

-- Click handler for popup
battery:subscribe("mouse.clicked", function(env)
	local drawing = battery:query().popup.drawing
	battery:set({ popup = { drawing = "toggle" } })

	if drawing == "off" then
		sbar.exec("pmset -g batt", function(batt_info)
			local found, _, remaining = batt_info:find(" (%d+:%d+) remaining")
			local label = found and remaining .. "h" or "No estimate"
			remaining_time:set({ label = { string = label } })
		end)
	end
end)
