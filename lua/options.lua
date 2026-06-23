-- Globals
vim.g.have_nerd_font = true -- iTerm uses a Nerd Font (0xProto NFM) -> icons render
vim.opt.showmode = false
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.wrap = false
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true -- required by nvim-colorizer and true-color themes

-- Mouse
vim.opt.mouse = "a"                 -- enable mouse in all modes (incl. command-line)
vim.opt.mousescroll = "ver:2,hor:4" -- smoother/faster scroll
vim.opt.mousemodel = "popup_setpos" -- right-click moves cursor + opens a menu
vim.opt.mousemoveevent = true       -- let statuslines/plugins react to hover

-- Right-click (PopUp) menu: LSP actions on the symbol under the cursor
vim.cmd([[
  amenu PopUp.Go\ to\ Definition  <cmd>lua vim.lsp.buf.definition()<CR>
  amenu PopUp.Find\ References    <cmd>lua vim.lsp.buf.references()<CR>
  amenu PopUp.Rename\ Symbol      <cmd>lua vim.lsp.buf.rename()<CR>
  amenu PopUp.Code\ Action        <cmd>lua vim.lsp.buf.code_action()<CR>
  amenu PopUp.-lsp-sep-           <Nop>
]])
vim.keymap.set("n", "<Leader>w", ":w<CR>", {})  -- Save
vim.keymap.set("n", "<Leader>q", ":q<CR>", {})  -- Quit (warns on unsaved changes)
vim.keymap.set("n", "<Leader>Q", ":q!<CR>", {}) -- Force quit, discard changes
vim.keymap.set("n", "<Leader>x", ":x<CR>", {})  -- Save and quit

-- Verticals
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})
vim.keymap.set("n", "<C-d>", "<C-d>zz", {})

-- Navigate (split/pane navigation handled by vim-tmux-navigator: <C-h/j/k/l>)
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
