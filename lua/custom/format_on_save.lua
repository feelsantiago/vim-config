-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
-- 	pattern = "*",
-- 	desc = "Run LSP formatting on a file on save",
-- 	callback = function(args)
-- 		local clients = vim.lsp.get_active_clients()
-- 		local format = false
--
-- 		for _, client in pairs(clients) do
-- 			if client.supports_method("textDocument/formatting") then
-- 				format = true
-- 				break
-- 			end
-- 		end
--
-- 		local isOil = vim.bo.filetype == "oil"
-- 		local autoformat_enabled = vim.b.autoformat_enabled
-- 		if autoformat_enabled == nil then
-- 			autoformat_enabled = vim.g.autoformat_enabled
-- 		end
--
-- 		if format and autoformat_enabled and vim.g.autoformat_enabled and not isOil then
-- 			require("conform").format({ bufnr = args.buf })
-- 			vim.diagnostic.enable(true)
-- 		end
-- 	end,
-- })
