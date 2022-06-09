local beautiful = require("beautiful")
local vicious = require("vicious")
local gears = require("gears")
local wibox = require("wibox")

local batbox = wibox.widget({
	{
		max_value = 1,
		widget = wibox.widget.progressbar,
		shape = gears.shape.rounded_bar,
		border_width = 0.5,
		border_color = "#3c3836",
		color = {
			type = "linear",
			from = { 0, 0 },
			to = { 0, 30 },
			stops = { { 0, "#b8bb26" }, { 0.5, "#83c07c" }, { 1, "#fb4934" } },
		},
	},
	forced_height = 10,
	forced_width = 8,
	direction = "east",
	color = beautiful.fg_widget,
	layout = wibox.container.rotate,
})

vicious.register(batbox, vicious.widgets.bat, "$2", 61, "BAT0")

return batbox
