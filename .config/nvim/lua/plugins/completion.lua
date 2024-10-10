return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- TODO 'L3MON4D3/LuaSnip',

		-- Adds other completion capabilities.
		-- nvim-cmp does not ship with all sources by default. They are split
		-- into multiple repos for maintenance purposes.
		-- TODO load following only when lsp needed
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
	},
	opts = {
		sources = {
			{ name = "nvim_lsp" },
			{ name = "path" },
		},
	},
	config = function(config)
		local cmp = require("cmp")
		local cmp_map = cmp.mapping

		-- For an understanding of why these mappings were
		-- chosen, you will need to read `:help ins-completion`
		--
		-- No, but seriously. Please read `:help ins-completion`, it is really good!
		config.opts.mapping = cmp_map.preset.insert({
			-- Select the [n]ext item
			["<C-n>"] = cmp_map.select_next_item(),
			-- Select the [p]revious item
			["<C-p>"] = cmp_map.select_prev_item(),
			-- Scroll the documentation window [b]ack / [f]orward
			["<C-j>"] = cmp_map.scroll_docs(-4),
			["<C-f>"] = cmp_map.scroll_docs(4),
			-- [K]lear the completion list.
			["<C-k>"] = cmp_map.abort(),
			-- Symmetric key for trigger completion back.
			["<C-d>"] = cmp_map.complete(),
			-- Accept ([y]es) the completion.
			-- This will auto-import if your LSP supports it.
			-- This will expand snippets if the LSP sent a snippet.
			-- ["<C-y>"] = cmp_map.confirm({ select = true }),
		})

		cmp.setup(config.opts)
	end,
}
