-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "MaterialOcean"
config.font = wezterm.font "JetBrains Mono"
config.window_decorations = "RESIZE"--|MACOS_FORCE_DISABLE_SHADOW"
config.hide_tab_bar_if_only_one_tab = true
config.initial_rows = 50
config.initial_cols = 175

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
