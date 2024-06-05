-- Globals
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("n", "<Leader>w", ":w<CR>", {})
vim.keymap.set("n", "<Leader>q", ":q<CR>", {})
vim.keymap.set("n", "<C-v>", ":vsplit<CR>", {})

-- Verticals
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})
vim.keymap.set("n", "<C-d>", "<C-d>zz", {})

-- Search
vim.keymap.set("n", "n", "nzz", {})
vim.keymap.set("n", "N", "Nzz", {})
vim.keymap.set("n", "<esc><esc>", ":noh<CR>", {})

-- Navigate
vim.keymap.set('n', 'C-k>' , ':wincmd k<CR>')
vim.keymap.set('n', 'C-h>' , ':wincmd h<CR>')
vim.keymap.set('n', 'C-j>' , ':wincmd j<CR>')
vim.keymap.set('n', 'C-l>' , ':wincmd l<CR>')



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
