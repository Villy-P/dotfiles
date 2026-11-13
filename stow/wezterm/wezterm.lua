-- WezTerm config, ported from kitty.conf
-- Location: ~/.config/wezterm/wezterm.lua  (or ~/.wezterm.lua)
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Shell: PowerShell 7 so your profile loads
config.default_prog = { 'pwsh.exe', '-NoLogo' }

-- font_family "CaskaydiaCove Nerd Font Mono"
config.font = wezterm.font 'CaskaydiaCove Nerd Font Mono'

-- background_opacity 0.80
config.window_background_opacity = 0.80
-- Optional: blur behind the window (newer WezTerm builds on Windows 11)
-- config.win32_system_backdrop = 'Acrylic'

-- dynamic_background_opacity yes: toggle between 0.80 and fully opaque
wezterm.on('toggle-opacity', function(window, _)
  local overrides = window:get_config_overrides() or {}
  if overrides.window_background_opacity == 1.0 then
    overrides.window_background_opacity = 0.80
  else
    overrides.window_background_opacity = 1.0
  end
  window:set_config_overrides(overrides)
end)

config.keys = {
  { key = 'o', mods = 'CTRL|SHIFT', action = wezterm.action.EmitEvent 'toggle-opacity' },
}

return config
