local utils = require("core.utils")

function js_formatters()
	if utils.is_deno_project() then
		return { "deno_fmt", stop_after_first = true }
	else
		return { "prettierd", "prettier", stop_after_first = true }
	end
end

return {
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		event = { "BufWritePre" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua", stop_after_first = true },
				javascript = js_formatters,
				typescript = js_formatters,
				html = js_formatters,
				css = js_formatters,
				json = js_formatters,
				markdown = js_formatters,
				go = { "gofumpt", "golines", "goimports-reviser" },
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
