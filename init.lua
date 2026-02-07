require("core.options")
require("core.keymaps")

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.

-- Disable statusline in Neovim (using vim-tpipeline to show in tmux instead)
vim.o.showmode = false
vim.o.cmdheight = 0
vim.o.laststatus = 0

vim.g.python3_host_prog = "/Applications/Xcode.app/Contents/Developer/usr/bin/python3"

vim.opt.runtimepath:prepend(vim.fn.stdpath("data") .. "/site")

vim.env.PATH = vim.env.PATH .. ":/opt/homebrew/bin"

require("lazy").setup("plugins")
