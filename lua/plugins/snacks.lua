return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		explorer = {
			enabled = true,
			win = {
				list = {
					keys = {
						["q"] = false,
						["<C-s>"] = false,
					},
				},
			},
		},
		indent = { enabled = true },
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

		-- Toggle Snacks Explorer mapping
		vim.keymap.set("n", "<leader>e", function()
			local explorer_win
			for _, w in ipairs(vim.api.nvim_list_wins()) do
				local buf = vim.api.nvim_win_get_buf(w)
				local ft = vim.bo[buf].filetype
				if ft == "snacks_picker_list" then
					explorer_win = w
					break
				end
			end

			if explorer_win then
				if vim.api.nvim_get_current_win() == explorer_win then
					vim.api.nvim_win_close(explorer_win, true)
				else
					vim.api.nvim_set_current_win(explorer_win)
				end
			else
				require("snacks").explorer()
			end
		end, { desc = "Toggle Snacks Explorer" })
	end,
}
