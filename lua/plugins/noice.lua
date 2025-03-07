return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				lsp = {
					hover = { silent = true },
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				routes = {
					{
						filter = {
							event = "msg_show",
							any = {
								{ find = "%d+L, %d+B" },
								{ find = "; after #%d+" },
								{ find = "; before #%d+" },
							},
						},
						opts = { skip = true },
					},
				},
				presets = {
					bottom_search = true,
					long_message_to_split = true,
					lsp_doc_border = true,
				},
				cmdline = {
					view = "cmdline",
				},
			})
		end,
	},
}
