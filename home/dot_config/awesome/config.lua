local awful = require("awful")

local terminal = "kitty"
local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal .. " -e " .. editor
local icon_theme = "Papirus-Dark"
local icon_path = "/usr/share/icons/" .. icon_theme .. "/32x32/"

return {
	terminal = terminal,
	editor = editor,
	editor_cmd = editor_cmd,
	wallpaper = "/usr/share/backgrounds/archlinux/awesome.png",
	modkey = "Mod4",
	icon_dirs = {
		icon_path .. "apps/",
		icon_path .. "actions/",
		icon_path .. "devices/",
		icon_path .. "status/",
	},
	icon_path = icon_path,
	icon_theme = icon_theme,
	icon_formats = { "svg", "png" },
	layouts = {
		-- awful.layout.suit.floating,
		awful.layout.suit.spiral,
		awful.layout.suit.tile,
		awful.layout.suit.tile.left,
		awful.layout.suit.tile.bottom,
		awful.layout.suit.tile.top,
		-- awful.layout.suit.fair,
		-- awful.layout.suit.fair.horizontal,
		-- awful.layout.suit.spiral.dwindle,
		-- awful.layout.suit.max,
		-- awful.layout.suit.max.fullscreen,
		-- awful.layout.suit.magnifier,
		-- awful.layout.suit.corner.nw,
		-- awful.layout.suit.corner.ne,
		-- awful.layout.suit.corner.sw,
		-- awful.layout.suit.corner.se,
	},
}
