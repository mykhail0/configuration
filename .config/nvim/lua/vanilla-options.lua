local v = vim
local g = v.g

-- Set the <leader> key.
g.mapleader = " "
g.maplocalleader = " "

local o = v.o

o.colorcolumn = "80"
o.relativenumber = true

-- tab configuration
local tabwidth = 4

o.expandtab = true
o.smartindent = true
o.tabstop = tabwidth
o.shiftwidth = tabwidth

-- Key mappings
local k = v.keymap

-- Remap for compatibility with default tmux prefix.
k.set("n", "<C-j>", "<C-b>")

-- Move between windows with <leader>hjkl
k.set("n", "<leader>h", "<C-w>h")
k.set("n", "<leader>j", "<C-w>j")
k.set("n", "<leader>k", "<C-w>k")
k.set("n", "<leader>l", "<C-w>l")

-- Resize windows with <leader>+-<>
k.set("n", "<leader>=", "<C-w>+")
k.set("n", "<leader>-", "<C-w>-")
k.set("n", "<leader><", "<C-w>5<")
k.set("n", "<leader>>", "<C-w>5>")

-- Closing windows
k.set("n", "<leader>q", "<C-w>c")
k.set("n", "<leader>o", "<C-w>o")

-- Move current window to a new tab
k.set("n", "<leader>nt", "<C-w>T")

local api = v.api

api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		v.highlight.on_yank()
	end,
})

-- LSP configuration

local lsp = v.lsp

lsp.enable({
	"pyright",
	"ruff",
	"clangd",
	"rust_analyzer",
	"hls",
	"lua_ls",
	"bashls",
	"texlab",
})

api.nvim_create_autocmd("LspAttach", {
	group = api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
	callback = function(args)
		local client = lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		if client.name == "ruff" then
			-- Disable hover in favor of Pyright
			client.server_capabilities.hoverProvider = false
		end
	end,
	desc = "LSP: Disable hover capability from Ruff",
})

-- Folding configuration
o.foldmethod = "expr"
-- Default to treesitter folding
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

--  This function gets run when an LSP attaches to a particular buffer.
--  That is to say, every time a new file is opened that is associated with
--  an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--  function will be executed to configure the current buffer
-- Prefer LSP folding if client supports it.
api.nvim_create_autocmd("LspAttach", {
	group = api.nvim_create_augroup("lsp_attach_folding", { clear = true }),
	callback = function(args)
		local client = lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		if client:supports_method("textDocument/foldingRange") then
			local win = api.nvim_get_current_win()
			v.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
	end,
})

api.nvim_create_autocmd("LspAttach", {
	group = api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
	callback = function(event)
		-- We create a function that lets us more easily define mappings specific
		-- for LSP related items. It sets the mode, buffer and description for us each time.
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			v.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		local builtin = require("telescope.builtin")

		-- Jump to the definition of the word under your cursor.
		--  This is where a variable was first declared, or where a function is defined, etc.
		--  To jump back, press <C-t>.
		map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")

		-- WARN: This is not Goto Definition, this is Goto Declaration.
		--  For example, in C this would take you to the header.
		map("gD", lsp.buf.declaration, "[G]oto [D]eclaration")

		-- Fuzzy find all the symbols in your current workspace.
		--  Similar to document symbols, except searches over your entire project.
		map("gW", builtin.lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
	end,
})
