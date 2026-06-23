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

-- Auto-reload buffers when the file changes on disk (e.g. Claude edits it).
-- `autoread` is on by default, but Neovim only re-reads on an explicit check,
-- so we run `checktime` on focus/idle to pull external changes in instantly.
vim.opt.autoread = true
vim.opt.updatetime = 1000 -- CursorHold fires after 1s idle (default 4s)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "TermClose", "TermLeave" }, {
	pattern = "*",
	command = "checktime",
})
-- Tell me when a reload actually happened.
vim.api.nvim_create_autocmd("FileChangedShellPost", {
	pattern = "*",
	callback = function()
		vim.notify("File changed on disk — buffer reloaded", vim.log.levels.WARN)
	end,
})

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

-- Exit terminal mode with a double-tap of <Esc>. A single <Esc> is left alone
-- so it still reaches terminal programs that use it (e.g. Claude Code's interrupt).
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

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
