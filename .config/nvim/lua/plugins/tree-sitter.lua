return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			-- Various
			"vimdoc",
			"awk",
			-- Compiled
			"c",
			"cpp",
			"rust",
			"java",
			"haskell",
			-- Scripting
			"bash",
			"python",
			"lua",
			-- Assembly
			"asm",
			"nasm",
			"llvm",
			-- Web
			"javascript",
			"typescript",
			"html",
			"css",
			-- Data formats
			"xml",
			"json",
			"toml",
			"yaml",
			-- Automation
			"make",
			"cmake",
			"dockerfile",
			-- Markup
			"markdown",
			"latex",
		},
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
		},
	},
	main = "nvim-treesitter.configs",
}
