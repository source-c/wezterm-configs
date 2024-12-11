local helpers = require 'helpers'

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- For example, setting the deafult color scheme (to cover the case it is not set deeper):
config.color_scheme = 'Wez'

-- Not to touch the clipboard content at any price
config.canonicalize_pasted_newlines = "None"

-- mimic the iTerm2 behaviour
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

-- default size and history buffer
config.initial_rows = 50
config.initial_cols = 160
config.scrollback_lines = 50000

-- dim inactive pane
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.4,
}

-- And here we may apply any other configuration including additional helpers
helpers.apply_to_config(config)

-- and finally, return the configuration to wezterm
return config