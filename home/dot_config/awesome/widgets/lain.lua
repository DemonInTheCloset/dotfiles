local lain = require("lain")
local wibox = require("wibox")

local lsep = lain.util.separators.arrow_left
local rsep = lain.util.separators.arrow_right

return {
	lsep = lsep,
	rsep = rsep,
	arrows = function(bgcol, sepcol, widgets, output)
		for i, val in ipairs(widgets) do
			local lcolor = (widgets[i - 1] or { color = bgcol }).color
			output[3 * i - 2] = lsep(lcolor, sepcol)
			output[3 * i - 1] = lsep(sepcol, val.color)
			output[3 * i] = wibox.container.background(val.widget, val.color)
		end

		return output
	end,
	bat = lain.widget.bat({
		settings = function()
			if bat_now.status == "N/A" then
				return
			end
			widget:set_markup(bat_now.status .. ": " .. bat_now.perc .. "% ")
		end,
	}),
	cpu = lain.widget.cpu({
		settings = function()
			widget:set_markup("CPU: " .. cpu_now.usage .. "%")
		end,
	}),
}
