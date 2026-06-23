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

			-- General keymaps (all under <leader>f = Find)
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
			vim.keymap.set("n", "<leader>fs", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "Search for String" })
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Open Buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
			vim.keymap.set("n", "<leader>f/", function()
				builtin.current_buffer_fuzzy_find({ layout_strategy = "vertical" })
			end, { desc = "Fuzzy Find in Buffer" })

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
