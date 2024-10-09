return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function(config)
		require("telescope").setup(config.opts)
		local builtin = require("telescope.builtin")
		local k = vim.keymap
		k.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		k.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		k.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		k.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		k.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		k.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		k.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
		k.set("n", "<leader>sc", function()
			builtin.colorscheme({
				-- Set available to dual themes.
				-- minimal coloring: quiet
				-- The best: default
				-- below doesn't work
				--[[
				colors = {
					"retrobox",
					"wildcharm",
					"lunaperche",
					"quiet",
					"default",
				},
				ignore_builtins = true,
                --]]
				enable_preview = true,
			})
		end, { desc = "[S]earch [C]olorscheme" })
		--k.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
		--k.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
		--k.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
	end,
}
