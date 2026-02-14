return {
	"folke/trouble.nvim",
	config = function()
		require("trouble").setup({
			open_no_results = true,
			warn_no_results = true,
		})
	end,
}
