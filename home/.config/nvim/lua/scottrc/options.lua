
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.scottrc_dir = "X:/src/"
vim.g.scottrc_home = "~"

function dirSpecifiedByArgs()
	local status, plenary = pcall(require, "plenary")
	if not status then 
		return false
	end
	local Path = plenary.Path

	-- ignore exe
	for i=2,#vim.v.argv do
		local arg = Path:new(vim.v.argv[i])
		if Path.is_dir(arg) or Path.is_file(arg) then
			return true
		end
	end
	return false
end

-- change to a default dir if nvim wasn't opened with args
if not dirSpecifiedByArgs() then
	vim.fn.chdir(vim.g.scottrc_dir)
end

local o = vim.opt
o.backup = false
o.clipboard = "unnamed"
o.fileencoding = "utf-8"
o.ignorecase = true
o.hlsearch = true
o.mouse = "a"
o.showtabline = 1
o.smartcase = true
o.smartindent = true
o.swapfile = false
o.undofile = true
o.writebackup = false
o.expandtab = false
o.shiftwidth = 4
o.tabstop = 4
o.cursorline = true
o.number = true
o.relativenumber = true
o.termguicolors = true
o.cmdheight = 1
o.timeoutlen = 300

o.wrap = true
o.scrolloff = 10
o.sidescrolloff = 10

