return {
	"andrewferrier/debugprint.nvim",
	dependencies = {
		"echasnovski/mini.nvim",
	},
	lazy = false,
	version = "*",
	opts = {
		keymaps = {
			normal = {
				plain_below = "<leader>dp",
				plain_above = "<leader>dP",
				variable_below = "<leader>dv",
				variable_above = "<leader>dV",
				textobj_below = "<leader>do",
				textobj_above = "<leader>O",
				toggle_comment_debug_prints = "<leader>dc",
				delete_debug_prints = "<leader>dd",
			},
			visual = {
				plain_below = "<leader>dp",
				plain_above = "<leader>dP",
				variable_below = "<leader>dv",
				variable_above = "<leader>dV",
				textobj_below = "<leader>do",
				textobj_above = "<leader>O",
			},
		},
	},
}
