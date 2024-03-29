-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.color_scheme = "MaterialOcean"
config.font = wezterm.font "JetBrains Mono", { weight = "ExtraBold" }
config.window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW"
config.hide_tab_bar_if_only_one_tab = true
config.front_end = "WebGpu"
config.window_background_opacity = 0.99

local act = wezterm.action
config.keys = {
  { key = '\\', mods = 'CMD|CTRL', action = act.SplitHorizontal },
  { key = '-',  mods = 'CMD|CTRL', action = act.SplitVertical },
  { key = 'w',  mods = 'CMD',      action = wezterm.action.CloseCurrentPane { confirm = true } },
  { key = 'k',  mods = 'CMD|CTRL', action = act.ActivatePaneDirection 'Up' },
  { key = 'j',  mods = 'CMD|CTRL', action = act.ActivatePaneDirection 'Down' },
  { key = 'l',  mods = 'CMD|CTRL', action = act.ActivatePaneDirection 'Right' },
  { key = 'h',  mods = 'CMD|CTRL', action = act.ActivatePaneDirection 'Left' },
}

-- and finally, return the configuration to wezterm
return config
