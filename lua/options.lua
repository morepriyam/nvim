-- Globals
vim.opt.showmode = false
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.wrap = false
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("n", "<Leader>w", ":w<CR>", {}) -- Save
vim.keymap.set("n", "<Leader>q", ":q<CR>", {}) -- Quit

-- Verticals
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})
vim.keymap.set("n", "<C-d>", "<C-d>zz", {})

-- Navigate
vim.keymap.set("n", "C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "C-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<Leader>W", ":set wrap!<CR>", {})

-- Global debug
P = function(v)
	print(vim.inspect(v))
	return v
end

Reload = function(...)
	require("plenary.reload").reloadmodule(...)
end

R = function(name)
	Reload(name)
	return require(name)
end
