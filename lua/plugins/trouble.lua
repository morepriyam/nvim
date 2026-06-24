return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Trouble",
	opts = {
		focus = true, -- jump into the Trouble window when it opens
	},
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble: all problems (workspace)" },
		{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble: problems (current file)" },
		{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Trouble: document symbols" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble: quickfix list" },
		{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble: location list" },
	},
}
