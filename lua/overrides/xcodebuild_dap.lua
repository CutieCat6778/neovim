-- Safe override for xcodebuild.nvim's DAP console clearing
vim.schedule(function()
	local status, integrations = pcall(require, "xcodebuild.integrations.dap")
	if not status then
		return
	end

	if not integrations.clear_console then
		return
	end

	local original_clear_console = integrations.clear_console

	integrations.clear_console = function(validate)
		local ok, dapui = pcall(require, "dapui")
		if not ok or not dapui or not dapui.elements or not dapui.elements.console then
			-- dap-ui not ready yet – silently skip clearing (no error)
			return
		end

		local bufnr = dapui.elements.console.buffer()
		if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
			return
		end

		if vim.bo[bufnr].buftype == "terminal" then
			if validate then
				local isMacOS = require("xcodebuild.project.config").settings.platform
					== require("xcodebuild.core.constants").Platform.MACOS
				if isMacOS then
					require("xcodebuild.notifications").send_error(
						"Cannot clear DAP console while debugging macOS apps."
					)
				else
					require("xcodebuild.notifications").send_error(
						"Cannot clear DAP console when it's a terminal buffer."
					)
				end
			end
			return
		end

		vim.bo[bufnr].modifiable = true
		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
		vim.bo[bufnr].modified = false
		vim.bo[bufnr].modifiable = false
	end
end)
