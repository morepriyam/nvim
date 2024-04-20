vim.g.mapleader = " "
vim.keymap.set("n", "<Leader>v", vim.cmd.Ex)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.showcmd = true
vim.opt.backup = false

vim.opt.cmdheight = 0
vim.opt.scrolloff = 10
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.backspace = { "start", "eol", "indent" }

vim.keymap.set("n", "<Leader>w", ":w<CR>", {})
vim.keymap.set("n", "<Leader>q", ":q<CR>", {})

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
