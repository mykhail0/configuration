return {
	"neovim/nvim-lspconfig",
	ft = { "python", "c", "cpp", "rust", "haskell", "lua", "bash", "sh", "tex" },
	config = function()
		--  This function gets run when an LSP attaches to a particular buffer.
		--  That is to say, every time a new file is opened that is associated with
		--  an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
		--  function will be executed to configure the current buffer
		local v = vim
		local api = v.api
		api.nvim_create_autocmd("LspAttach", {
			group = api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
			callback = function(event)
				-- NOTE: Remember that Lua is a real programming language, and as such it is possible
				-- to define small helper and utility functions so you don't have to repeat yourself.
				--
				-- In this case, we create a function that lets us more easily define mappings specific
				-- for LSP related items. It sets the mode, buffer and description for us each time.
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					v.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				local lsp = v.lsp.buf
				local builtin = require("telescope.builtin")

				-- Rename the variable under your cursor.
				--  Most Language Servers support renaming across files, etc.
				map("grn", lsp.rename, "[R]e[n]ame")

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map("gra", lsp.code_action, "[G]oto Code [A]ction", { "n", "x" })

				-- Find references for the word under your cursor.
				map("grr", builtin.lsp_references, "[G]oto [R]eferences")

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				map("gri", builtin.lsp_implementations, "[G]oto [I]mplementation")

				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header.
				map("gD", lsp.declaration, "[G]oto [D]eclaration")

				-- Fuzzy find all the symbols in your current document.
				--  Symbols are things like variables, functions, types, etc.
				map("gO", builtin.lsp_document_symbols, "Open Document Symbols")

				-- Fuzzy find all the symbols in your current workspace.
				--  Similar to document symbols, except searches over your entire project.
				map("gW", builtin.lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				map("grt", builtin.lsp_type_definitions, "[G]oto [T]ype Definition")
			end,
		})
	end,
}
