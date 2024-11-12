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
	--[[
	{
		"4e554c4c/darkman.nvim",
		build = "go build -o bin/darkman.nvim",
		opts = {
			change_background = true,
			send_user_event = false,
			-- colorscheme = nil, -- can be { dark = "x", light = "y" }
		},
	},
    --]]
}
