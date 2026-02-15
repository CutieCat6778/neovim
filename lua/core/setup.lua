require("remote-sshfs").callback.on_connect_success:add(function(host, mount_dir)
	local name = host.host or host.hostname or "unknown"
	vim.notify("Mounted " .. name .. " at " .. mount_dir)
end)

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local dir = vim.fn.expand("%:p:h")
		if dir ~= "" then
			vim.cmd("lcd " .. vim.fn.fnameescape(dir))
		end
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
