return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	keys = {
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer (tab)" },
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer (tab)" },
		{ "<leader>bd", "<cmd>bdelete<cr>", desc = "Close buffer" },
		{ "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Pin buffer" },
	},
	opts = {
		options = {
			mode = "buffers",
			diagnostics = "nvim_lsp", -- show LSP errors/warnings on tabs (like VSCode)
			separator_style = "thin",
			show_buffer_close_icons = true,
			show_close_icon = false,
			always_show_bufferline = true,
			offsets = {
				{
					filetype = "neo-tree",
					text = "EXPLORER",
					highlight = "Directory",
					separator = true,
				},
			},
		},
	},
}
