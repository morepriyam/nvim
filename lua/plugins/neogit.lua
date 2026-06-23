return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim", -- diff integration (already installed)
		"nvim-telescope/telescope.nvim", -- fuzzy selectors
	},
	cmd = "Neogit",
	keys = {
		{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit (source control panel)" },
	},
	config = function()
		require("neogit").setup({
			integrations = {
				diffview = true,
				telescope = true,
			},
		})
	end,
}
