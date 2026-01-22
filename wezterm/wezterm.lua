--  refer to https://wezterm.org/config/files.html
-- https://wezterm.org/colorschemes/e/index.html#everforest-dark-medium-gogh

-- refer to https://github.com/wsgggws/slides-md-ppt/blob/main/wezterm/wezterm.lua

local wezterm = require("wezterm")
local config = wezterm.config_builder()
-- This is where you actually apply your config choices.

config.font = wezterm.font("RecMonoCasual Nerd Font Mono")
config.font_size = 16.0
-- disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95
config.macos_window_background_blur = 30
config.initial_cols = 140
config.initial_rows = 45
config.default_cursor_style = "SteadyBar"

config.window_close_confirmation = "NeverPrompt"

config.color_scheme = "Gruvbox Dark (Gogh)"

-- config.color_scheme = 'Gruvbox dark, medium (base16)'

config.adjust_window_size_when_changing_font_size = false

return config
