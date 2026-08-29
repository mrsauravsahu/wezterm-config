local wezterm = require('wezterm')
local platform = require('utils.platform')

-- Base font size (used as-is on macOS). On Linux this is adjusted per-window at
-- runtime for hi-DPI displays by events/font-resize.lua -- wezterm.gui.screens()
-- is only callable on the gui thread, so it can't be done here at config-eval.
local font_size = 18

-- Primary font. Keep macOS on the 'Mono' variant (unchanged); on Linux use the
-- installed 'GeistMono Nerd Font' family (~/.local/share/fonts/GeistMonoNerdFont-Regular.otf).
local geist_font = platform.is_mac
   and { family = 'GeistMono Nerd Font Mono' }
   or { family = 'GeistMono Nerd Font' }

return {
  font_size = font_size,
  font = wezterm.font_with_fallback {
    -- SF Mono is Apple-proprietary and not shipped by the Nerd Fonts project.
    -- Installed via `brew install --cask font-sf-mono-nerd-font-ligaturized`
    -- (family name 'Liga SFMono Nerd Font').
    "MesloLGM Nerd Font Mono",
    "UbuntuMono Nerd Font Mono",
    "JetBrains Mono",
    { family = 'Liga SFMono Nerd Font', weight = 'Medium' },
    geist_font,
  },
  warn_about_missing_glyphs = false,
  --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
  -- freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
  -- freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
