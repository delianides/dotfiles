local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 18
config.color_scheme = "catppuccin-mocha"
config.enable_tab_bar = false

return config
