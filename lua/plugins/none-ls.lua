return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		local sources = {
			-- Go
			formatting.goimports,

			-- Make
			diagnostics.checkmake,

			-- Web
			formatting.prettier.with({
				filetypes = { "html", "json", "yaml", "markdown", "javascript" },
			}),

			-- Lua
			formatting.stylua,

			-- Shell (indent 4)
			formatting.shfmt.with({ args = { "-i", "4" } }),

			-- C / C++ (indent 4) — uses .clang-format if present, otherwise fallback style
			formatting.clang_format.with({
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
				extra_args = {
					"--style={IndentWidth: 4, TabWidth: 4, UseTab: Never}",
				},
			}),
		}

		null_ls.setup({
			sources = sources,
			on_attach = function(client, bufnr)
				-- Only let none-ls format on save (prevents clangd/others formatting too)
				if client.name ~= "null-ls" then
					return
				end

				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								bufnr = bufnr,
								async = false,
								filter = function(c)
									return c.name == "null-ls"
								end,
							})
						end,
					})
				end
			end,
		})
	end,
}
