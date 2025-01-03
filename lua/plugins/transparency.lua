return {
	"xiyaowong/transparent.nvim",
	lazy = false,
	opts = {
		extra_groups = {
			"NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
			"NvimTreeNormal", -- NvimTree
			"Pmenu",
			"Float",
		},
		lualine_style = "default",
		-- lualine_style = "stealth",
	},
	config = function()
		vim.cmd("TransparentEnable")
		vim.cmd("highlight Pmenu guibg=NONE")
		vim.cmd("highlight NormalFloat guibg=NONE")
		vim.cmd("highlight Float guibg=NONE")
	end,
}
