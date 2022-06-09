local beautiful = require("beautiful")
local vicious = require("vicious")
local gears = require("gears")
local wibox = require("wibox")

local batbox = wibox.layout.margin(
	wibox.widget({
		{
			max_value = 1,
			widget = wibox.widget.progressbar,
			border_width = 0.5,
			shape = gears.shape.rounded_bar,
			border_color = "#282828",
			color = {
				type = "linear",
				from = { 0, 0 },
				to = { 0, 10 },
				--stops = { { 0, "#fb4934" }, { 1, "#83c07c" } },
				stops = { { 0, "#83c07c" }, { 1, "#fb4934" } },
			},
		},
		forced_height = 10,
		forced_width = 8,
		direction = "east",
		color = beautiful.fg_widget,
		layout = wibox.container.rotate,
	}),
	1,
	1,
	3,
	3
)

vicious.register(batbox, vicious.widgets.bat, "$2", 61, "BAT0")

return batbox
