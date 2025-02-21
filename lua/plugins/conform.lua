return {
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		event = { "BufWritePre" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				go = { "gofumpt", "goimports" },
				-- Use the "*" filetype to run formatters on all filetypes.
				["*"] = { "codespell" },
			},
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				local autoformat_enabled = vim.b[bufnr].autoformat_enabled
				if autoformat_enabled == nil then
					autoformat_enabled = vim.g.autoformat_enabled
				end

				if autoformat_enabled or not vim.bo.filetype == "oil" then
					return { timeout_ms = 500, lsp_format = "fallback" }
				end
			end,
		},
		init = function()
			vim.keymap.set("n", "<leader>lf", function()
				require("conform").format()
			end, { desc = "Format file" })
			vim.keymap.set("v", "<leader>lf", function()
				require("conform").format()
			end, { desc = "Format file" })
		end,
	},
}
