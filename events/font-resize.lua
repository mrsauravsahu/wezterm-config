local wezterm = require('wezterm')
local platform = require('utils.platform')

local M = {}

-- Base font size; keep in sync with config/fonts.lua.
local BASE = 18

-- On hi-DPI (4K/5K, >= 3840px wide) displays the base size renders ~1.25x too
-- large, so scale it down. Tweak the threshold/factor to taste.
---@param screen table|nil a screen from wezterm.gui.screens()
local function size_for_screen(screen)
   if screen and (screen.width or 0) >= 3840 then
      return BASE / 1.25 -- ~14.4 on 4K/5K
   end
   return BASE
end

-- Adjust font size to the display the window is currently on. Runs on the gui
-- thread (where wezterm.gui.screens() is available) and re-fires whenever the
-- config reloads, so moving a window between monitors of different resolution
-- picks up the right size on the next reload.
M.setup = function()
   -- macOS is intentionally left untouched.
   if platform.is_mac then
      return
   end

   wezterm.on('window-config-reloaded', function(window)
      local ok, screens = pcall(wezterm.gui.screens)
      if not ok or not screens then
         return
      end

      local target = size_for_screen(screens.active or screens.main)
      local overrides = window:get_config_overrides() or {}
      -- Guard against an infinite reload loop: only override when it changes.
      if overrides.font_size ~= target then
         overrides.font_size = target
         window:set_config_overrides(overrides)
      end
   end)
end

return M
