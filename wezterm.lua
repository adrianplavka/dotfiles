-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.term = "xterm-256color"
config.color_scheme = "Dotshare (terminal.sexy)"
-- config.color_scheme = "Argonaut"
-- config.color_scheme = "Abernathy"
-- config.color_scheme = "Ciapre"
-- config.color_scheme = "Dawn (terminal.sexy)"
-- config.color_scheme = "Peppermint"
-- config.color_scheme = "Pulp (terminal.sexy)"

config.font = wezterm.font("JetBrains Mono", { weight = "DemiBold" })
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.98
config.hyperlink_rules = wezterm.default_hyperlink_rules()
config.mouse_bindings = {
  -- Disable the default click behavior
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = wezterm.action.DisableDefaultAssignment,
  },
  -- Command/Ctrl-click will open the link under the mouse cursor
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "SUPER",
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
  -- Disable the Ctrl-click down event to stop programs from seeing it when a URL is clicked
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "SUPER",
    action = wezterm.action.Nop,
  },
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = wezterm.action.Nop,
  },
}

return config
