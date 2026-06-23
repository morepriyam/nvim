return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		indent = { char = "│" },
		scope = {
			enabled = true, -- highlight the active indent level (like VSCode)
			show_start = false,
			show_end = false,
		},
	},
}
