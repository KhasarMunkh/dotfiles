local wezterm = require 'wezterm'
-- zen mode handler
wezterm.on('user-var-changed', function(window, pane, name, value)
    local overrides = window:get_config_overrides() or {}
    if name == "ZEN_MODE" then
        local incremental = value:find("+")
        local number_value = tonumber(value)
        if incremental ~= nil then
            while (number_value > 0) do
                window:perform_action(wezterm.action.IncreaseFontSize, pane)
                number_value = number_value - 1
            end
            overrides.enable_tab_bar = false
        elseif number_value < 0 then
            window:perform_action(wezterm.action.ResetFontSize, pane)
            overrides.font_size = nil
            overrides.enable_tab_bar = true
        else
            overrides.font_size = number_value
            overrides.enable_tab_bar = false
        end
    end
    window:set_config_overrides(overrides)
end)

return {
  default_domain = "WSL:Ubuntu",
  font = wezterm.font 'Hack Nerd Font',
  font_size = 13.0,
  color_scheme = 'Catppuccin Mocha',
  colors = {
    tab_bar = {
      background = '#1E1E2E',
      active_tab = {
        bg_color = '#F5E0DC',
        fg_color = '#1E1E2E',
      },
      inactive_tab = {
        bg_color = '#282A36',
        fg_color = '#6272A4',
      },
      inactive_tab_hover = {
        bg_color = '#44475A',
        fg_color = '#F8F8F2',
      },
    },
  },
  use_fancy_tab_bar = true,
  check_for_updates = false,
  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5,
  },

  keys = {
    -- Vim-like pane movement
    { key = 'h', mods = 'CTRL', action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'j', mods = 'CTRL', action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'k', mods = 'CTRL', action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'l', mods = 'CTRL', action = wezterm.action.ActivatePaneDirection 'Right' },
    -- Splits
    { key = '\\', mods = 'CTRL', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = '-', mods = 'CTRL', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
    -- Reload config
    { key = 'r', mods = 'CTRL|SHIFT', action = wezterm.action.ReloadConfiguration },
  }
}
