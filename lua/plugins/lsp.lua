return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)

				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local group = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = group,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = group,
						callback = vim.lsp.buf.clear_references,
					})
				end

			end,
		})

		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)

		local servers = {
			clangd = {},
			gopls = {
				settings = { gopls = { analyses = { unusedparams = false }, staticcheck = true } },
			},
			rust_analyzer = {},
			ruff = {},
			pylsp = {
				settings = {
					pylsp = {
						plugins = {
							pyflakes = { enabled = false },
							pycodestyle = { enabled = false },
							autopep8 = { enabled = false },
							yapf = { enabled = false },
							mccabe = { enabled = false },
							pylsp_mypy = { enabled = false },
							pylsp_black = { enabled = false },
							pylsp_isort = { enabled = false },
						},
					},
				},
			},
			html = { filetypes = { "html", "twig", "hbs" } },
			cssls = {
				settings = {
					css = { lint = { unknownAtRules = "ignore" } },
					scss = { lint = { unknownAtRules = "ignore" } },
					less = { lint = { unknownAtRules = "ignore" } },
				},
			},
			tailwindcss = {},
			dockerls = {},
			sqlls = {},
			jsonls = {},
			yamlls = {},
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						completion = { callSnippet = "Replace" },
						diagnostics = { disable = { "missing-fields" } },
						workspace = {
							checkThirdParty = false,
							library = { "${3rd}/luv/library", unpack(vim.api.nvim_get_runtime_file("", true)) },
						},
						format = { enable = false },
					},
				},
			},
			texlab = {},
		}

		require("mason").setup()

		local ensure_installed = vim.tbl_keys(servers)
		vim.list_extend(ensure_installed, { "stylua" })

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})

		vim.lsp.config("sourcekit", {
			cmd = { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) },
			filetypes = { "swift", "objective-c", "objective-cpp" },
			root_markers = { "Package.swift", ".git" },
			capabilities = vim.tbl_deep_extend("force", capabilities, {
				workspace = {
					didChangeWatchedFiles = { dynamicRegistration = true },
				},
			}),
		})

		vim.lsp.enable("sourcekit")

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.diagnostic.config({
			float = { border = "rounded" },
			virtual_text = true,
			signs = { active = signs },
		})
	end,
}
