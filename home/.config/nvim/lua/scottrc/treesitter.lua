local status, configs = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

configs.setup({
	ensure_installed = { 
		"gdscript",
		"bash",
		"c",
		"cpp",
		"css",
		"gitattributes",
		"gitcommit",
		"glsl",
		"hlsl",
		"java",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"rust",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"yaml",
	},
	highlight = {
		enable = true,
		-- disable treesitter for nvim help docs, crashes
		disable = { "help" }
	},
	indent = { enable = false },
})
