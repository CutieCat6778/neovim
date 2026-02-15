require("remote-sshfs").callback.on_connect_success:add(function(host, mount_dir)
	local name = host.host or host.hostname or "unknown"
	vim.notify("Mounted " .. name .. " at " .. mount_dir)
end)

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(args)
		local buf = args.buf
		if vim.bo[buf].buftype ~= "" then
			return
		end

		local name = vim.api.nvim_buf_get_name(buf)
		if name == "" then
			return
		end

		local dir = vim.fs.dirname(name)
		if not dir or vim.fn.isdirectory(dir) ~= 1 then
			return
		end

		pcall(vim.cmd, { cmd = "lcd", args = { dir } })
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		if vim.bo[args.buf].filetype == "oil" then
			return
		end
		require("conform").format({ bufnr = args.buf, lsp_fallback = true, timeout_ms = 2000 })
	end,
})
