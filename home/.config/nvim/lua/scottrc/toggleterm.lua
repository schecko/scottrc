local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	dir = vim.g.scottrc_dir,
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	-- start_in_insert = true,
	insert_mappings = true,
	focusable = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "single",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

local Terminal = require("toggleterm.terminal").Terminal

local scratch = Terminal:new({ dir = vim.g.scottrc_dir, hidden = true })
function _SCRATCH_TOGGLE()
	scratch:toggle()
end

local working = Terminal:new({
	dir = vim.g.scottrc_dir,
	direction = "horizontal",
	size = 30,
	hidden = true,
})
function _WORKING_TOGGLE()
	working:toggle()
end

local node = Terminal:new({ cmd = "node", hidden = true })
function _NODE_TOGGLE()
	node:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })
function _PYTHON_TOGGLE()
	python:toggle()
end
