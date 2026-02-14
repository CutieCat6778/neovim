return {
	"nvim-telescope/telescope.nvim",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		require("telescope").setup({
			defaults = {
				preview = {
					-- telescope 0.1.5 expects old nvim-treesitter parser APIs.
					-- Disable TS preview highlighting to avoid callback errors.
					treesitter = false,
				},
			},
		})
	end,
}
