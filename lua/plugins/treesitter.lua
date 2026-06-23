return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	build = ":TSUpdate",

	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = { "c", "lua", "rust", "go", "java", "python", "typescript", "javascript", "tsx", "html", "css", "json", "yaml", "toml", "bash", "dockerfile", "prisma", "markdown", "markdown_inline" },

			auto_install = true,
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			additional_vim_regex_highlighting = false,
		})
	end,
}
