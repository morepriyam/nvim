return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({

			filesystem = {
				follow_current_file = { enabled = true },
				filtered_items = {
					visible = true,
					show_hidden_count = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				hijack_netrw_behavior = "open_default",
			},
		})
		vim.keymap.set("n", "<Leader>n", "<Cmd>Neotree toggle<CR>", { desc = "Neo-tree (files)" })
		-- Git changes in neo-tree style (changed files in the sidebar)
		vim.keymap.set("n", "<Leader>gt", "<Cmd>Neotree toggle git_status<CR>", { desc = "Neo-tree git changes" })
	end,
}
