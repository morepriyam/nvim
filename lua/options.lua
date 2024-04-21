vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("n", "<Leader>w", ":w<CR>", {})
vim.keymap.set("n", "<Leader>q", ":q<CR>", {})

-- Verticals
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})
vim.keymap.set("n", "<C-d>", "<C-d>zz", {})

-- Search
vim.keymap.set("n", "n", "nzz", {})
vim.keymap.set("n", "N", "Nzz", {})
vim.keymap.set("n", "<esc><esc>", ":noh<CR>", {})

-- Disable arrow
vim.keymap.set("", "<Up>", "", {})
vim.keymap.set("", "<Down>", "", {})
vim.keymap.set("", "<Left>", "", {})
vim.keymap.set("", "<Right>", "", {})

-- Window Navigation <C-ww> -  toggle
vim.keymap.set("n", "<C-h>", "<C-w>h", {})
vim.keymap.set("n", "<C-l>", "<C-w>l", {})
vim.keymap.set("n", "<C-j>", "<C-w>j", {})
vim.keymap.set("n", "<C-k>", "<C-w>k", {})
vim.keymap.set("n", "<C-v>", ":vsplit<CR>", {})

--tab
vim.keymap.set("n", "<C-t>", ":tabnext<CR>", {})

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
