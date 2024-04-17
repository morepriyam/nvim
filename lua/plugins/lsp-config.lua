return {{
	"williamboman/mason.nvim",
	config = function()
		require("mason").setup()
	end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
			ensure_installed = {"lua_ls", "tsserver", "prismals", "tailwindcss", "eslint"}
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		config =  function()
			local lspconfig = require('lspconfig')
			lspconfig.tsserver.setup({})
			lspconfig.lua_ls.setup({})
			lspconfig.prismals.setup({})
			lspconfig.tailwindcss.setup({})
			lspconfig.eslint.setup({})

			vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
			vim.keymap.set('n', 'cd', vim.lsp.buf.definition, {})
			vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
		end
	}
}
