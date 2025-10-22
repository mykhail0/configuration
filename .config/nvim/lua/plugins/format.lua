local v = vim

local formatters_by_ft = v.tbl_map(function(formatter_config)
	formatter_config.lsp_format = "never"
	return formatter_config
end, {
	lua = { "stylua" },
	c = { "clang-format" },
	cpp = { "clang-format" },
	rust = { "rustfmt" },
	tex = { "tex-fmt" },
})

return {
	"stevearc/conform.nvim",
	ft = v.tbl_keys(formatters_by_ft),
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>ff",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format the current buffer",
		},
	},
	opts = {
		formatters_by_ft = formatters_by_ft,
		default_format_opts = {
			timeout_ms = 2000,
			lsp_format = "fallback",
		},
		format_on_save = {},
	},
	config = function(config)
		local conform = require("conform")
		conform.setup(config.opts)
		v.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		conform.formatters["clang-format"] = {
			append_args = { "--style", "Google" },
		}
	end,
}
