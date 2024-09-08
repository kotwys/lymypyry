local wezterm = require 'wezterm'
local config = {}

config.use_ime = false
config.term = 'wezterm'
config.set_environment_variables = {
  TERMINFO_DIRS = '/home/kotwys/.nix-profile/share/terminfo',
}

config.color_scheme = 'Base2Tone Motel Dark'
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

config.initial_cols = 100
config.colors = {
  visual_bell = '#202020',
  foreground = '#b3a8aa',
  tab_bar = {
    active_tab = {
      bg_color = '#444444',
      fg_color = 'white'
    },
    inactive_tab = {
      bg_color = '#303030',
      fg_color = 'white',
    },
    inactive_tab_hover = {
      bg_color = '#3f3f3f',
      fg_color = 'white',
    },
    new_tab = {
      bg_color = '#303030',
      fg_color = 'white',
    },
    new_tab_hover = {
      bg_color = '#3f3f3f',
      fg_color = 'white',
    },
  }
}

config.window_padding = {
  left = '1.5cell',
  right = '1cell',
  top = '0.5cell',
  bottom = '0cell'
}

config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 50,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 150,
}

config.window_frame = {
  font = wezterm.font 'Ubuntu',
  font_size = 11.0,
}

config.window_background_opacity = 0.95
config.enable_scroll_bar = true
config.font = wezterm.font_with_fallback {
  {
    family = 'ui-monospace',
  },
  'Meiryo UI' -- Japanese
}
config.font_size = 10
config.line_height = 1.5
config.underline_position = '-0.2cell'

local bell_path = '/run/current-system/sw/share/sounds/freedesktop/stereo/bell.oga'
wezterm.on('bell', function (window, pane)
  -- Run audible bell because on Wayland it is not supported
  wezterm.background_child_process {
    'cvlc',
    '--play-and-exit',
    bell_path
  }
end)

return config
