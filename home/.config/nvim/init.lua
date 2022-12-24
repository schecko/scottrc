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

require "scottrc.whichkey"

if vim.g.neovide then
	require "scottrc.neovide"
end
