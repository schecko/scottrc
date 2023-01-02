local status, status_line = pcall(require, "lualine")
if not status then
  return
end

status_line.setup{
	options = {
		theme = "tokyonight",
		refresh = {
		  statusline = 1000,
		  tabline = 1000,
		  winbar = 1000,
		},
	},
	extensions = { "toggleterm" },
}

