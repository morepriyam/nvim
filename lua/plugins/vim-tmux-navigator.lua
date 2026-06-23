return {
	"christoomey/vim-tmux-navigator",
	-- The plugin's built-in mappings use a Vim-only `<C-w>` trick to leave
	-- terminal mode, which does nothing in Neovim (no default terminal <C-w>),
	-- so C-h/j/k/l fall through to tmux from terminals. Disable them and define
	-- our own below using <cmd>, which runs the command directly from any mode.
	init = function()
		vim.g.tmux_navigator_no_mappings = 1
	end,
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	keys = {
		-- mode n+t so you can navigate OUT of terminals (Claude Code, lazygit, etc.)
		{ "<c-h>", "<cmd>TmuxNavigateLeft<cr>", mode = { "n", "t" }, desc = "Window left" },
		{ "<c-j>", "<cmd>TmuxNavigateDown<cr>", mode = { "n", "t" }, desc = "Window down" },
		{ "<c-k>", "<cmd>TmuxNavigateUp<cr>", mode = { "n", "t" }, desc = "Window up" },
		{ "<c-l>", "<cmd>TmuxNavigateRight<cr>", mode = { "n", "t" }, desc = "Window right" },
		-- normal-mode only: keep <C-\><C-n> usable to exit terminal mode
		{ "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Window previous" },
	},
}
