return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		view_options = { show_hidden = true },
	},
	config = function(config)
		require("oil").setup(config.opts)
		vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
	end,
	lazy = false,
}
