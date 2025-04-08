return {
	default = 0x80ffffff,
	transparent = 0x00000000,
	text = 0xffcdd6f4,

	black = 0xff181825,
	white = 0xffffffff,
	red = 0xfff38ba8,
	red_bright = 0xfff5e0dc, -- watch
	green = 0xffa6e3a1,
	blue = 0xff89b4fa,
	blue_bright = 0xfff5e0dc, -- watch
	yellow = 0xfff9e2af,
	orange = 0xfffab387,
	magenta = 0xffcba6f7,
	grey = 0xff585b70,

	bar = {
		bg = 0xff181825,
		border = 0xff313244,
	},

	popup = {
		bg = 0xff313244,
		border = 0xff7f8490,
	},

	bg1 = 0xff313244,
	bg2 = 0xff45475a,

	accent = 0xffb482c2,
	accent_bright = 0x33efc2fc,

	spotify_green = 0xe040a02b,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}
