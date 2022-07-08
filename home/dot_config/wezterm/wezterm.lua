local wezterm = require("wezterm")

return {
	-- Appearance
	-- -- Tab Bar
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	-- -- Window
	window_background_image = "/usr/share/backgrounds/archlinux/awesome.png",
	-- -- Color Scheme
	color_scheme = "Gruvbox Dark",
	-- Font
	font = wezterm.font("Iosevka Term Extended", { weight = "Medium" }),
	font_size = 11.0,
}
