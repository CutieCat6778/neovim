return {
	"wojciech-kulik/xcodebuild.nvim",
	dependencies = {
		-- Uncomment a picker that you want to use, snacks.nvim might be additionally
		-- useful to show previews and failing snapshots.

		-- You must select at least one:
		"nvim-telescope/telescope.nvim",
		-- "ibhagwan/fzf-lua",
		-- "folke/snacks.nvim", -- (optional) to show previews

		"MunifTanjim/nui.nvim",
		"nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
	},
	config = function()
		require("xcodebuild").setup({
			integrations = {
				nvim_tree = { enabled = false },
				oil_nvim = { enabled = false },
				telescope_nvim = { enabled = true },
				snacks_nvim = { enabled = false },
			},
		})
	end,
}
