local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- General
config.font_size = 12
config.font = wezterm.font("GoogleSansCode Nerd Font Mono")
config.color_scheme = "Catppuccin Mocha"

-- Window
config.enable_wayland = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

return config
