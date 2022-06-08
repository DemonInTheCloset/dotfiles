local awful = require("awful")
local wibox = require("wibox")

local launcher = require("widgets/launcher")
local textclock = require("widgets/textclock")
local battery = require("widgets/battery")
local netstatus = require("widgets/netstatus")
local volume = require("widgets/volume")
local brightness = require("widgets/brightness")
local keyboardlayout = require("widgets/keyboardlayout")

return function(s)
	local taskbar = awful.wibar({ position = "top", screen = s })

	taskbar:setup({
		-- Add widgets to the wiboxs.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			launcher,
			s.mytaglist,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			netstatus,
			wibox.widget.textbox("  "),
			volume,
			wibox.widget.textbox("  "),
			brightness,
			wibox.widget.textbox("  "),
			battery,
			wibox.widget.textbox("  "),
			textclock,
			wibox.widget.textbox("  "),
			keyboardlayout,
			wibox.widget.systray(),
			s.mylayoutbox,
		},
	})
	return taskbar
end
