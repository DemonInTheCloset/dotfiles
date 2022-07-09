local wezterm = require("wezterm")

return {
	-- Appearance
	-- -- Tab Bar
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	-- -- Window
	-- window_background_image = "/usr/share/backgrounds/archlinux/wave.png",
	window_background_opacity = 0.8,
	-- -- Color Scheme
	color_scheme = "Gruvbox Dark",
	-- Font
	font = wezterm.font("Iosevka Term Extended", { weight = "Medium" }),
	font_size = 11.0,
	-- Multiplexing
	unix_domains = {
		{ name = "unix" },
	},
	-- Default Arguments (connect to multiplexing session)
	default_gui_startup_args = { "connect", "unix" },
}
