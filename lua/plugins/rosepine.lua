-- Rose Pine kept installed as an alternative theme (NOT active).
-- Switch to it any time with:  :colorscheme rose-pine
return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			disable_background = true,
			styles = {
				italic = false,
			},
		})
	end,
}
