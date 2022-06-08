local awful = require("awful")

return awful.widget.watch("xbacklight -perceived -get", 10, function(widget, stdout)
	widget:set_text(" " .. stdout:match("%d+") .. "%")
end)
