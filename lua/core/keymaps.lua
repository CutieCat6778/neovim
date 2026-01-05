-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- Undo files
vim.keymap.set("i", "<C-z>", "<cmd> u <CR>", opts)
vim.keymap.set("i", "<C-S-z>", "<cmd> redo <CR>", opts)

-- Save file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts)
vim.keymap.set("i", "<C-s>", "<cmd> w <CR><Esc>", opts)
-- Save file without auto-formatting
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- Quit file
vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", opts)

-- Delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<C-w>", ":Bdelete!<CR>", opts) -- close buffer
vim.keymap.set("i", "<C-w>", ":Bdelete!<CR>", opts) -- close buffer
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts) -- new buffer

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts) -- split window vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts) -- close current split window

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts) --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-------------------------------------------------------------------------------
-- Xcodebuild Keymaps
-------------------------------------------------------------------------------

-- Xcode command palette / picker
vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", opts)
vim.keymap.set("n", "<leader>xf", "<cmd>XcodebuildProjectManager<cr>", opts)

-- Build & Run
vim.keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", opts)
vim.keymap.set("n", "<leader>xB", "<cmd>XcodebuildBuildForTesting<cr>", opts)
vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", opts)

-- Tests
vim.keymap.set("n", "<leader>xt", "<cmd>XcodebuildTest<cr>", opts)
vim.keymap.set("v", "<leader>xt", "<cmd>XcodebuildTestSelected<cr>", opts)
vim.keymap.set("n", "<leader>xT", "<cmd>XcodebuildTestClass<cr>", opts)
vim.keymap.set("n", "<leader>x.", "<cmd>XcodebuildTestRepeat<cr>", opts)

-- Logs & Coverage
vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", opts)
vim.keymap.set("n", "<leader>xc", "<cmd>XcodebuildToggleCodeCoverage<cr>", opts)
vim.keymap.set("n", "<leader>xC", "<cmd>XcodebuildShowCodeCoverageReport<cr>", opts)
vim.keymap.set("n", "<leader>xe", "<cmd>XcodebuildTestExplorerToggle<cr>", opts)
vim.keymap.set("n", "<leader>xs", "<cmd>XcodebuildFailingSnapshots<cr>", opts)

-- Previews
vim.keymap.set("n", "<leader>xp", "<cmd>XcodebuildPreviewGenerateAndShow<cr>", opts)
vim.keymap.set("n", "<leader>x<cr>", "<cmd>XcodebuildPreviewToggle<cr>", opts)

-- Devices & Quickfix
vim.keymap.set("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", opts)
vim.keymap.set("n", "<leader>xq", "<cmd>Telescope quickfix<cr>", opts)
vim.keymap.set("n", "<leader>xx", "<cmd>XcodebuildQuickfixLine<cr>", opts)
vim.keymap.set("n", "<leader>xa", "<cmd>XcodebuildCodeActions<cr>", opts)
