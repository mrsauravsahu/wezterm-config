local wezterm = require('wezterm')
local platform = require('utils.platform')

local font_size = platform.is_mac and 18 or 14

return {
  font_size = font_size,
  font = wezterm.font_with_fallback {
    -- {
    --   family = "Spot Mono",
    -- },
    -- {
    --   family = 'Terminus',
    --   weight = 'Bold'
    -- },
    {
      family = "UbuntuMono Nerd Font Mono",
    },
    {
      family = "MesloLGM Nerd Font Mono",
    },
    {
      family = 'JetBrains Mono',
      weight = 'Medium',
    },
    {
      family = "Iosevka Nerd Font Mono",
    },
    'Noto Color Emoji',
  },
  warn_about_missing_glyphs = false,
  --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
  -- freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
  -- freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
