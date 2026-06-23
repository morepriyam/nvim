return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")

			-- General keymaps
			vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<leader>plg", builtin.live_grep, { desc = "Live Grep" })
			vim.keymap.set("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "Search for String" })
			vim.keymap.set("n", "<leader>pof", builtin.oldfiles, { desc = "Recent Files" })
			vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Open Buffers" })
			vim.keymap.set("n", "<leader>pht", builtin.help_tags, { desc = "Help Tags" })
			vim.keymap.set("n", "<leader>fcf", function()
				builtin.current_buffer_fuzzy_find({ layout_strategy = "vertical" })
			end, { desc = "Current Buffer Fuzzy Find" })

			-- Telescope setup (single call registering both extensions)
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true, -- Enable fuzzy searching
						override_generic_sorter = true, -- Override generic sorter with fzf
						override_file_sorter = true, -- Override file sorter with fzf
						case_mode = "respect_case", -- Respect case when searching
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			-- Load extensions
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")
		end,
	},
}
