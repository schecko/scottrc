
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("installing packer, close and reopen nvim")
	vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
	augroup packer_reload_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]])

local packer_status, packer = pcall(require, "packer")
if not packer_status then
	return
end

packer.init()
return packer.startup(function(use)
	-- Base
	use { "wbthomason/packer.nvim" }
	use { 
		"nvim-lua/plenary.nvim",
		commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7"
	}

	-- Theme
	use { "folke/tokyonight.nvim" }

	-- Completion 
	use { "hrsh7th/nvim-cmp" } -- The completion plugin
	use { "hrsh7th/cmp-buffer" } -- buffer completions
	use { "hrsh7th/cmp-path" } -- path completions
	use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
	use { "hrsh7th/cmp-nvim-lua" }

	-- Snippets
	use {
		"L3MON4D3/LuaSnip",
		tag = "v1.1.0"
	} --snippet engine
	use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

	-- Treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		tag = "v0.8.1"
	}

	-- Telescope
	use { 
		"nvim-telescope/telescope.nvim", 
		requires = { { "nvim-lua/plenary.nvim" } },
		tag = "0.1.0",
	}

	-- Git
	use { 
		"lewis6991/gitsigns.nvim",
		tag = "v0.6"
	}

	-- Show keybindings
	use {
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end,
	}

	use { "nvim-tree/nvim-tree.lua" }
	use { "nvim-tree/nvim-web-devicons" }

	-- Fancy tab visuals
	use { 
		'romgrk/barbar.nvim',
		wants = 'nvim-web-devicons',
		tags = "1.4.0"
	}

	-- Fancy status line
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}


	-- Fancy terminal open
	use {
		"schecko/toggleterm.nvim",
		--tag = "2.3.0"
	}

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
