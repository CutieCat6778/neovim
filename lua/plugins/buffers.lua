return {
	{
		"famiu/bufdelete.nvim",
		cmd = { "Bdelete", "Bwipeout" },
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"famiu/bufdelete.nvim",
		},
		opts = {
			options = {
				mode = "buffers",
				always_show_bufferline = true,
				show_close_icon = false,
				show_buffer_close_icons = false,
				separator_style = "slant",
				diagnostics = "nvim_lsp",
			},
		},
		config = function(_, opts)
			vim.o.showtabline = 0
			require("bufferline").setup(opts)
		end,
	},
}
