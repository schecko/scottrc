if vim.fn.has("win32") then
	require "scottrc.windows"
elseif vim.fn.has("linux") then
	print "Warning, linux is not fully configured"
elseif vim.fn.has("mac") then
	vim.cmd[[normal! iYou monster]]
else
	print "Warning, plaform is not fully configured"
end

require "scottrc.options"
require "scottrc.keymaps"

require "scottrc.plugins"

require "scottrc.colorscheme"
require "scottrc.completion"

require "scottrc.nvim-tree"
require "scottrc.treesitter"
require "scottrc.telescope"
require "scottrc.bufferline"
require "scottrc.statusline"
require "scottrc.toggleterm"

require "scottrc.whichkey"

if vim.g.neovide then
	require "scottrc.neovide"
end
