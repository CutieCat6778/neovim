return {
	"stevearc/vim-arduino",
	lazy = false, -- lazy-loading will disable inverse search
	config = function()
		local opts = { noremap = true, silent = true }
		-- Arduino
		vim.keymap.set("n", "<leader>aa", "<cmd>ArduinoAttach<CR>", opts)
		vim.keymap.set("n", "<leader>av", "<cmd>ArduinoVerify<CR>", opts)
		vim.keymap.set("n", "<leader>au", "<cmd>ArduinoUpload<CR>", opts)
		vim.keymap.set("n", "<leader>aus", "<cmd>ArduinoUploadSerial<CR>", opts)
		vim.keymap.set("n", "<leader>as", "<cmd>ArduinoSerial<CR>", opts)
		vim.keymap.set("n", "<leader>ab", "<cmd>ArduinoChooseBoard<CR>", opts)
		vim.keymap.set("n", "<leader>ap", "<cmd>ArduinoChooseProgrammer<CR>", opts)
		-- Status Line
		if vim.bo.filetype ~= "arduino" then
			return ""
		end
		local port = vim.fn["arduino#GetPort"]()
		local line = string.format("[%s]", vim.g.arduino_board)
		if vim.g.arduino_programmer ~= "" then
			line = line .. string.format(" [%s]", vim.g.arduino_programmer)
		end
		if port ~= 0 then
			line = line .. string.format(" (%s:%s)", port, vim.g.arduino_serial_baud)
		end
		return line
	end,
}
