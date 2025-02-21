return { -- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",
	event = "VeryLazy",
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup()

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- Highlight word under cursor
		require("mini.cursorword").setup()

		-- Auto Close Pairs
		require("mini.pairs").setup()

		-- Move Selection
		require("mini.move").setup({
			mappings = {
				-- Move visual selection in Visual mode
				left = "<S-h>",
				right = "<S-l>",
				down = "<S-j>",
				up = "<S-k>",
			},
		})
	end,
}
