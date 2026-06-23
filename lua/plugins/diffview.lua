return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewToggleFiles",
		"DiffviewFocusFiles",
		"DiffviewRefresh",
		"DiffviewFileHistory",
	},
	keys = {
		{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview: all changes (VSCode-style)" },
		{ "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Diffview: close" },
		{ "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: current file history" },
		{ "<leader>gG", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: branch/repo history" },
	},
	config = function()
		require("diffview").setup({
			enhanced_diff_hl = true,
			view = {
				default = { layout = "diff2_horizontal" }, -- side-by-side
				merge_tool = { layout = "diff3_mixed" },
			},
			file_panel = {
				listing_style = "tree", -- neo-tree-style tree of changed files
			},
		})
	end,
}
