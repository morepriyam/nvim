return{
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},

	config = function()
		require("neo-tree").setup({
			close_if_last_window = true
		})

		vim.keymap.set({'n' , 'v'}, '<Leader>nn','<Cmd>Neotree reveal left<CR>')
		vim.keymap.set({'n' , 'v'}, '<Leader>n', '<Cmd>Neotree toggle<CR>')
	end
}

