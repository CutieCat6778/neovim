return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			dependencies = { "nvim-neotest/nvim-nio" },
			-- Make dap-ui load immediately when dap is loaded (no delay)
			lazy = false,
			config = function()
				local dap = require("dap")
				local dapui = require("dapui")

				dapui.setup()

				-- Auto open/close UI (you probably already have this)
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open()
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close()
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close()
				end
			end,
		},
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")

		-- Native Apple lldb-dap adapter (exact name the plugin checks for)
		dap.adapters["lldb-dap"] = {
			type = "executable",
			command = "xcrun",
			args = { "lldb-dap" },
			name = "lldb-dap",
		}

		-- Swift configurations (type must match the adapter key)
		dap.configurations.swift = {
			{
				name = "Debug Swift Executable (Manual)",
				type = "lldb-dap",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/.build/debug/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
			},
			{
				name = "Attach to Process",
				type = "lldb-dap",
				request = "attach",
				pid = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
		}

		-- Optional: Reuse for other languages if needed
		dap.configurations.objc = dap.configurations.swift
		dap.configurations.c = dap.configurations.swift
		dap.configurations.cpp = dap.configurations.swift

		-- Your keymaps
		local opts = { noremap = true, silent = true }
		vim.keymap.set("n", "<leader>dc", dap.continue, opts)
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)
		vim.keymap.set("n", "<leader>dr", dap.repl.open, opts)
		vim.keymap.set("n", "<leader>dl", dap.run_last, opts)
		vim.keymap.set("n", "<leader>di", dap.step_into, opts)
		vim.keymap.set("n", "<leader>do", dap.step_over, opts)
		vim.keymap.set("n", "<leader>du", dap.step_out, opts)
	end,
}
