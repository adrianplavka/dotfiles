-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action

config.font = wezterm.font("JetBrains Mono", { weight = "DemiBold" })
config.font_size = 15
config.term = "xterm-256color"
config.window_background_opacity = 0.98
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "home"
config.inactive_pane_hsb = {
  brightness = 0.5,
}

config.color_scheme = "Dotshare (terminal.sexy)"
-- config.color_scheme = "Argonaut"
-- config.color_scheme = "Abernathy"
-- config.color_scheme = "Ciapre"
-- config.color_scheme = "Dawn (terminal.sexy)"
-- config.color_scheme = "Peppermint"
-- config.color_scheme = "Pulp (terminal.sexy)"

config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  -- Pane configuration
  { key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "LeftArrow", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "DownArrow", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "UpArrow", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
  { key = "RightArrow", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

  { key = "c", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
  { key = "x", mods = "LEADER", action = act.RotatePanes("Clockwise") },
  { key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },

  -- Tabs configuration
  { key = "n", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "S", mods = "LEADER", action = act.ShowTabNavigator },
  { key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },

  -- Workspace configuration
  { key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1),
  })
end

config.key_tables = {
  resize_pane = {
    { key = "<", action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "-", action = act.AdjustPaneSize({ "Down", 1 }) },
    { key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
    { key = "=", action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = ">", action = act.AdjustPaneSize({ "Right", 1 }) },
    { key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter", action = "PopKeyTable" },
  },
}

config.hyperlink_rules = wezterm.default_hyperlink_rules()
config.mouse_bindings = {
  -- Disable the default click behavior
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.DisableDefaultAssignment,
  },
  -- Command/Ctrl-click will open the link under the mouse cursor
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "SUPER",
    action = act.OpenLinkAtMouseCursor,
  },
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = act.OpenLinkAtMouseCursor,
  },
  -- Disable the Ctrl-click down event to stop programs from seeing it when a URL is clicked
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "SUPER",
    action = act.Nop,
  },
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = act.Nop,
  },
}

config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = false

wezterm.on("update-status", function(window, pane)
  local colors = {
    green = "#addaa2",
    blue = "#92b3f5",
    cyan = "#7dcfff",
    red = "#f7768e",
    grey = "#171717",
    black = "#000003",
  }

  -- Workspace name
  local stat = window:active_workspace()
  local stat_color = colors.green

  -- Utilize this to display LDR or current key table name
  if window:active_key_table() then
    stat = window:active_key_table()
    stat_color = colors.cyan
  end
  if window:leader_is_active() then
    stat = "LDR"
    stat_color = colors.red
  end

  local basename = function(s)
    -- Nothing a little regex can't fix
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
  end

  -- Current working directory
  local cwd = pane:get_current_working_dir()
  if cwd then
    if type(cwd) == "userdata" then
      -- Wezterm introduced the URL object in 20240127-113634-bbcac864
      cwd = basename(cwd.file_path)
    else
      -- 20230712-072601-f4abf8fd or earlier version
      cwd = basename(cwd)
    end
  else
    cwd = ""
  end

  -- Current command
  local cmd = pane:get_foreground_process_name()
  -- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
  cmd = cmd and basename(cmd) or ""

  -- Time
  local time = wezterm.strftime("%H:%M")

  -- Left status (left of the tab line)
  window:set_left_status(wezterm.format({
    { Foreground = { Color = stat_color } },
    { Text = "  " },
    { Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
    { Text = " |" },
  }))

  local SOLID_LEFT_CIRCLE = ""

  -- Right status
  window:set_right_status(wezterm.format({
    -- Wezterm has a built-in nerd fonts
    -- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
    { Foreground = { Color = colors.green } },
    { Text = " " .. wezterm.nerdfonts.md_folder .. "  " .. cwd },
    { Foreground = { Color = colors.grey } },
    { Text = " " .. SOLID_LEFT_CIRCLE },
    { Background = { Color = colors.grey } },
    { Foreground = { Color = colors.blue } },
    { Text = " " .. wezterm.nerdfonts.fa_code .. "  " .. cmd },
    { Foreground = { Color = colors.blue } },
    { Text = " " .. SOLID_LEFT_CIRCLE },
    { Background = { Color = colors.blue } },
    { Foreground = { Color = colors.black } },
    { Text = " " .. wezterm.nerdfonts.md_clock .. "  " .. time },
    { Text = " " },
  }))
end)

return config
