-- Standalone plugins with less than 10 lines of config go here
return {
	{
		-- Detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
	},
	{
		-- Powerful Git integration for Vim
		"tpope/vim-fugitive",
	},
	{
		-- GitHub integration for vim-fugitive
		"tpope/vim-rhubarb",
	},
	{
		-- Hints keybinds
		"folke/which-key.nvim",
	},
	{
		-- Autoclose parentheses, brackets, quotes, etc.
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
	{
		-- High-performance color highlighter
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		-- WakaTime time tracker
		"wakatime/vim-wakatime",
		lazy = false,
	},
	{
		"vimpostor/vim-tpipeline",
		event = "VeryLazy",
		config = function()
			vim.g.tpipeline_focuslost = 1
			vim.o.laststatus = 0
			vim.go.laststatus = 0
		end,
	},
	{
		"sudar/vim-arduino-syntax",
	},
	{
		"MunifTanjim/nui.nvim",
	},
	{
		"github/copilot.vim",
	},
	{
		"junegunn/fzf",
	},
	{
		"junegunn/fzf.vim",
		dependencies = { "junegunn/fzf" },
	},
}
