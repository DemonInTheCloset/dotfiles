local wezterm = require("wezterm")

local default_theme = "Gruvbox Dark"

local function str_is_empty(str)
    return str == nil or str == ""
end

local function xdg_data_home()
    local data_home = os.getenv("XDG_DATA_HOME")

    if str_is_empty(data_home) then
        return os.getenv("HOME") .. "/.local/share"
    end

    return data_home
end

local function get_current_theme()
    for line in io.lines(xdg_data_home() .. "/current_theme") do
        return line
    end

    return default_theme
end

return {
    check_for_updates = false, -- Managed by Package Manager
    -- Appearance
    -- -- Tab Bar
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = true,
    -- -- Window
    -- window_background_image = "/usr/share/backgrounds/archlinux/wave.png",
    window_background_opacity = 0.8,
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
    -- -- Color Scheme
    color_scheme = get_current_theme(),
    -- -- BEL feedback
    -- visual_bell = {
    -- 	fade_in_duration_ms = 50,
    -- 	fade_out_duration_ms = 50,
    -- 	target = "BackgroundColor",
    -- },
    -- audible_bell = "Disabled",
    -- Font
    font = wezterm.font("Iosevka Term Extended", { weight = "Medium" }),
    font_size = 11.0,
    -- Multiplexing
    unix_domains = {
        { name = "unix" },
    },
    -- Default Arguments (connect to multiplexing session)
    -- default_gui_startup_args = { "connect", "unix" },
}
