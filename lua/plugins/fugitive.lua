return {
	"tpope/vim-fugitive",
	dependencies = {
		"tpope/vim-rhubarb", -- enables :GBrowse to open files/lines on GitHub
	},
	cmd = {
		"Git",
		"G",
		"Gedit",
		"Gread",
		"Gwrite",
		"Gdiffsplit",
		"Gvdiffsplit",
		"Gclog",
		"Gllog",
		"Ggrep",
		"GMove",
		"GRename",
		"GDelete",
		"GRemove",
		"GBrowse",
	},
	keys = {
		-- Core
		{ "<leader>gs", "<cmd>Git<cr>", desc = "Git status (fugitive hub)" },
		{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
		{ "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git diff (split)" },
		{ "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
		{ "<leader>gl", "<cmd>Git log --oneline --decorate --graph<cr>", desc = "Git log" },
		-- Remote
		{ "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
		{ "<leader>gP", "<cmd>Git pull --rebase<cr>", desc = "Git pull (rebase)" },
		{ "<leader>gf", "<cmd>Git fetch<cr>", desc = "Git fetch" },
		-- Staging
		{ "<leader>ga", "<cmd>Git add -A<cr>", desc = "Git add all changes" },
		-- Current file
		{ "<leader>gw", "<cmd>Gwrite<cr>", desc = "Git stage current file" },
		{ "<leader>gr", "<cmd>Gread<cr>", desc = "Git checkout/discard current file" },
		{ "<leader>ge", "<cmd>Gedit<cr>", desc = "Git edit (back to working copy)" },
		{ "<leader>gB", "<cmd>GBrowse<cr>", mode = { "n", "v" }, desc = "Open in browser (GitHub)" },
		-- Merge-conflict resolution (use inside a 3-way diff)
		{ "<leader>gh", "<cmd>diffget //2<cr>", desc = "Conflict: take left (HEAD/target)" },
		{ "<leader>gm", "<cmd>diffget //3<cr>", desc = "Conflict: take right (merge/incoming)" },
	},
}
