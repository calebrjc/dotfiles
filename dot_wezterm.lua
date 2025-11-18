local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- General
config.font_size = 12
config.font = wezterm.font("GoogleSansCode Nerd Font Mono")
config.color_scheme = "Catppuccin Mocha"
config.initial_rows = 30
config.initial_cols = 120
config.default_cursor_style = "BlinkingUnderline"
config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Window
config.enable_wayland = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.audible_bell = "Disabled"

return config
