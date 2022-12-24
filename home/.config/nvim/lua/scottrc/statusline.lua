local status, status_line = pcall(require, "lualine")
if not status then
  return
end

local custome_theme = require "lualine.themes.nightfly"

status_line.setup{
	options = { theme = custome_theme },
}

