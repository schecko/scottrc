local opts = { noremap = true, silent = true }

local k = vim.api.nvim_set_keymap;
k("", "<Space>", "<Nop>", opts);
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Navigate views
k("n", "<C-h>", "<C-w>h", opts)
k("n", "<C-j>", "<C-w>j", opts)
k("n", "<C-k>", "<C-w>k", opts)
k("n", "<C-l>", "<C-w>l", opts)

-- The only binding that really matters
k("i", "jk", "<ESC>", opts)
