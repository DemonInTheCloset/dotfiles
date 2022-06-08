local awful = require("awful")

local icons = {
	charging = "",
	discharging = "",
}

local function get_icon(charge, iconset)
	if charge < 25 then
		return iconset:sub(1, 1)
	elseif charge < 35 then
		return iconset:sub(2, 2)
	elseif charge < 50 then
		return iconset:sub(3, 3)
	elseif charge < 70 then
		return iconset:sub(4, 4)
	elseif charge < 85 then
		return iconset:sub(5, 5)
	elseif charge < 95 then
		return iconset:sub(6, 6)
	else
		return iconset:sub(7, 7)
	end
end

return awful.widget.watch("acpi", 3, function(widget, stdout, stderr)
	if stderr and not (stderr == "") then
		-- No battery therefore plugged to the wall
		widget:set_text("AC: ")
		return
	end

	local status = (stdout:match("%d: [^,%%]+,") or ""):gsub("%d: ", ""):gsub(",", "")
	local scharge = stdout:match("%d+%%"):gsub("%%", "")
	local ok, charge = pcall(tonumber, scharge)
	local text = "ﮣ"

	if status == "Charging" then
		text = get_icon(charge, icons.charging) or text
	elseif status == "Discharging" then
		text = get_icon(charge, icons.discharging) or text
	end

	if ok then
		text = text .. " " .. scharge .. "%"
	end

	widget:set_text(text)
end)
