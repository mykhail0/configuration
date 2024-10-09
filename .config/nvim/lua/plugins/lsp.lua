-- LSPs' configurations
local servers = {
	pyright = {},
	clangd = {},
	rust_analyzer = {},
	hls = {},
	lua_ls = {},
	bashls = {},
}

return {
	"neovim/nvim-lspconfig",
	ft = { "python", "c", "cpp", "rust", "haskell", "lua", "bash", "sh" },
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	config = function()
		local v = vim
		local api = v.api
		local buf = v.lsp.buf
		-- This function gets run when an LSP attaches to a particular buffer.
		-- That is to say, every time a new file is opened that is associated
		-- with an lsp (for example, opening `main.rs` is associated with
		-- `rust_analyzer`) this function will be executed to configure the
		-- current buffer.
		api.nvim_create_autocmd("LspAttach", {
			group = api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				-- We create a function that lets us more easily define
				-- mappings specific for LSP related items. It sets the mode,
				-- buffer and description for us each time.
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					v.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				local pickers = require("telescope.builtin")

				-- Jump to the definition of the word under your cursor.
				-- This is where a variable was first declared, or where a
				-- function is defined, etc. To jump back, press <C-t>.
				map("gd", pickers.lsp_definitions, "[G]oto [D]efinition")

				-- Find references for the word under your cursor.
				map("gr", pickers.lsp_references, "[G]oto [R]eferences")

				-- Jump to the implementation of the word under your cursor.
				-- Useful when your language has ways of declaring types
				-- without an actual implementation.
				map("gI", pickers.lsp_implementations, "[G]oto [I]mplementation")

				-- Jump to the type of the word under your cursor.
				-- Useful when you're not sure what type a variable is and you
				-- want to see the definition of its *type*, not where it was
				-- *defined*.
				map("<leader>t", pickers.lsp_type_definitions, "Type [D]efinition")

				-- Fuzzy find all the symbols in your current document.
				-- Symbols are things like variables, functions, types, etc.
				map("<leader>ds", pickers.lsp_document_symbols, "[D]ocument [S]ymbols")

				-- Fuzzy find all the symbols in your current workspace.
				-- Similar to document symbols, except searches over your
				-- entire project.
				map("<leader>ws", pickers.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				-- Rename the variable under your cursor.
				-- Most Language Servers support renaming across files, etc.
				map("<leader>rn", buf.rename, "[R]e[n]ame")

				-- Execute a code action, usually your cursor needs to be on
				-- top of an error or a suggestion from your LSP for this to
				-- activate.
				map("<leader>ca", buf.code_action, "[C]ode [A]ction", { "n", "x" })

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				-- For example, in C this would take you to the header.
				map("gD", buf.declaration, "[G]oto [D]eclaration")
			end,
		})

		-- LSP servers and clients are able to communicate to each other what
		-- features they support. By default, Neovim doesn't support everything
		-- that is in the LSP specification. When you add nvim-cmp, luasnip,
		-- etc. Neovim now has *more* capabilities. So, we create new
		-- capabilities with nvim cmp, and then broadcast that to the servers.
		local capabilities = v.lsp.protocol.make_client_capabilities()
		capabilities = v.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
		local lspconfig = require("lspconfig")
		for server, config in pairs(servers) do
			config.capabilities = v.tbl_deep_extend("force", capabilities, config.capabilities or {})
			lspconfig[server].setup(config)
		end
	end,
}
