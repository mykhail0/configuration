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
local servers = {
	"pyright",
	"ruff",
	"clangd",
	"rust_analyzer",
	"hls",
	"lua_ls",
	"bashls",
	"texlab",
}

v.lsp.enable(servers)
