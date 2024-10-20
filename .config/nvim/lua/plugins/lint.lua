-- TODO
-- You can call `try_lint` with a linter name or a list of names to always
-- run specific linters, independent of the `linters_by_ft` configuration
--require("lint").try_lint("cspell")

local linters_by_ft = {
	python = { "mypy", "ruff", "pylint" },
	c = { "clangtidy" },
	cpp = { "clangtidy" },
	rust = { "clippy" },
	html = { "tidy" },
}

local v = vim
local api = v.api

return {
	"mfussenegger/nvim-lint",
	ft = v.tbl_keys(linters_by_ft),
	keys = {
		{
			"<leader>fl",
			function()
				-- try_lint without arguments runs the linters defined in
				-- `linters_by_ft` for the current filetype
				require("lint").try_lint()
			end,
			desc = "Lint the current buffer",
		},
	},
	config = function()
		require("lint").linters_by_ft = linters_by_ft
		api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			desc = "Lint on write",
			group = api.nvim_create_augroup("lint", { clear = true }),
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
