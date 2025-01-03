vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
	pattern = "*",
	desc = "Run LSP formatting on a file on save",
	callback = function()
		local client = vim.lsp.get_active_clients()[1]
		local isOil = vim.bo.filetype == "oil"
		local autoformat_enabled = vim.b.autoformat_enabled
		if autoformat_enabled == nil then
			autoformat_enabled = vim.g.autoformat_enabled
		end
		if
			client
			and client.supports_method("textDocument/formatting")
			and autoformat_enabled
			and vim.g.autoformat_enabled
			and not isOil
		then
			vim.lsp.buf.format()
		end
	end,
})
