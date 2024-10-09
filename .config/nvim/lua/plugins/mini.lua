local minigit = {
	"echasnovski/mini-git",
	main = "mini.git",
	dependencies = {
		"echasnovski/mini.diff",
	},
}

return {
	minigit,
	-- fidget.nvim
	"echasnovski/mini.notify",
	{
		-- lualine
		"echasnovski/mini.statusline",
		dependencies = {
			minigit,
			"echasnovski/mini.icons",
		},
	},
	{
		-- 'echasnovski/mini.hipatterns'
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
