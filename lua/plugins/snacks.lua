return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		explorer = {
			enabled = false,
			win = {
				list = {
					keys = {
						["q"] = false,
						["<C-s>"] = false,
					},
				},
			},
		},
		indent = { enabled = false },
		input = { enabled = true },
		picker = {
			enabled = true,
			hidden = true,
			ignored = true,
			sources = {
				files = {
					hidden = true,
					ignored = true,
					exclude = {
						"**/.git/*",
					},
				},
			},
			exclude = {
				"**/.git/*",
			},
		},
		image = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = false },
		words = { enabled = true },
	},
	config = function(_, opts)
		require("snacks").setup(opts)
	end,
}
