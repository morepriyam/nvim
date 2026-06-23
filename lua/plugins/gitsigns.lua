return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gs = require("gitsigns")
				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end

				-- Navigation between hunks
				map("n", "]c", function()
					gs.nav_hunk("next")
				end, "Next Hunk")
				map("n", "[c", function()
					gs.nav_hunk("prev")
				end, "Prev Hunk")

				-- Actions
				map("n", "<Leader>hs", gs.stage_hunk, "Stage Hunk")
				map("n", "<Leader>hr", gs.reset_hunk, "Reset Hunk")
				map("n", "<Leader>hS", gs.stage_buffer, "Stage Buffer")
				map("n", "<Leader>hR", gs.reset_buffer, "Reset Buffer")
				map("n", "<Leader>hp", gs.preview_hunk, "Preview Hunk")
				map("n", "<Leader>hb", function()
					gs.blame_line({ full = true })
				end, "Blame Line")
				map("n", "<Leader>hd", gs.diffthis, "Diff This")
				map("n", "<Leader>tb", gs.toggle_current_line_blame, "Toggle Line Blame")
			end,
		})
	end,
}
