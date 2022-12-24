local opts = { noremap = true, silent = true }

local k = vim.api.nvim_set_keymap;
k("", "<Space>", "<Nop>", opts);
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------------------------------------------
-- Normal Mode
-----------------------------------------------------

-- Navigate views
k("n", "<C-h>", "<C-w>h", opts)
k("n", "<C-j>", "<C-w>j", opts)
k("n", "<C-k>", "<C-w>k", opts)
k("n", "<C-l>", "<C-w>l", opts)

-- Resize views with arrows
k("n", "<C-up>", ":resize -2<cr>", opts)
k("n", "<C-down>", ":resize +2<cr>", opts)
k("n", "<C-left>", ":vertical resize -2<cr>", opts)
k("n", "<C-right>", ":vertical resize +2<cr>", opts)

-----------------------------------------------------
-- Insert Mode
-----------------------------------------------------

-- The only binding that really matters
k("i", "jk", "<ESC>", opts)

-----------------------------------------------------
-- Visual Mode
-----------------------------------------------------

k("v", "<", "<gv", opts)
k("v", ">", ">gv", opts)

-----------------------------------------------------
-- Terminal Mode
-----------------------------------------------------

k("t", "jk", "<c-\\><c-n>", opts)
k("t", "<ESC>", "<c-\\><c-n>", opts)

k("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
k("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
k("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
k("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)
