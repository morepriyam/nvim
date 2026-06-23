return {
	"Mofiqul/vscode.nvim",
	priority = 1000, -- load before everything else so highlights are set first
	lazy = false,
	config = function()
		require("vscode").setup({
			transparent = false, -- solid VSCode Dark+ background (#1e1e1e)
			italic_comments = true,
			underline_links = true,
			terminal_colors = true,
			disable_nvimtree_bg = true,
		})
		vim.o.background = "dark"
		require("vscode").load()
	end,
}
