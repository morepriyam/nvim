return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		-- Labels for your prefix namespaces (shown as groups in the popup)
		spec = {
			{ "<leader>a", group = "AI / Claude" },
			{ "<leader>b", group = "Buffers" },
			{ "<leader>g", group = "Git" },
			{ "<leader>h", group = "Git Hunks" },
			{ "<leader>d", group = "Debug" },
			{ "<leader>r", group = "Rust / Rename" },
			{ "<leader>f", group = "Find / Pickers" },
			{ "<leader>c", group = "Code" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer-local keymaps (which-key)",
		},
	},
}
