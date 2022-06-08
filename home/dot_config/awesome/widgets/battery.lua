local awful = require("awful")

return awful.widget.watch("acpi", 30, function(widget, stdout, stderr)
	if stderr and not (stderr == "") then
		-- No battery therefore plugged to the wall
		widget:set_text("AC: ")
		return
	end
	widget:set_text(stdout)
end)
