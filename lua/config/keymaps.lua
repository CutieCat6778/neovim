-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--

-- use `vim.keymap.set` instead
local map = vim.keymap.set

map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prevoius Buffer" })
map("n", "<C-w>", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
