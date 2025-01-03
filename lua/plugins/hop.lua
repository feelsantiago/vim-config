return {
	"phaazon/hop.nvim",
	branch = "v2",
	event = "VeryLazy",
	config = function()
		-- you can configure Hop the way you like here; see :h hop-config
		require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		local directions = require("hop.hint").HintDirection

		vim.keymap.set("n", "<leader>j1", "<cmd>HopChar1<CR>", { desc = "Hop 1 letter" })
		vim.keymap.set("n", "<leader>j2", "<cmd>HopChar2<CR>", { desc = "Hop 2 letter" })
		vim.keymap.set("n", "<leader>f1", "<cmd>HopChar1<CR>", { desc = "Hop 1 letter" })
		vim.keymap.set("n", "<leader>f2", "<cmd>HopChar2<CR>", { desc = "Hop 2 letter" })
		vim.keymap.set("n", "<leader>jl", "<cmd>HopLine<CR>", { desc = "Hop Line" })
		vim.keymap.set("n", "<leader>js", "<cmd>HopLineStart<CR>", { desc = "Hop Line Start" })
		vim.keymap.set("n", "<leader>jv", "<cmd>HopVertical<CR>", { desc = "Hop Vertical" })
		vim.keymap.set("n", "<leader>jp", "<cmd>HopPattern<CR>", { desc = "Hop Pattern" })
		vim.keymap.set("n", "<leader>jw", "<cmd>HopWord<CR>", { desc = "Hop Word" })
		vim.keymap.set("n", "<leader>jw", "<cmd>HopAnywhere<CR>", { desc = "Hop Word" })
		vim.keymap.set("n", "f", function()
			require("hop").hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
		end, { desc = "Find with hop", remap = true })
		vim.keymap.set("n", "F", function()
			require("hop").hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
		end, { desc = "Find with hop", remap = true })
		vim.keymap.set("n", "t", function()
			require("hop").hint_char1({
				direction = directions.AFTER_CURSOR,
				current_line_only = true,
				hint_offset = -1,
			})
		end, { desc = "Find with hop", remap = true })
		vim.keymap.set("n", "T", function()
			require("hop").hint_char1({
				direction = directions.BEFORE_CURSOR,
				current_line_only = true,
				hint_offset = -1,
			})
		end, { desc = "Find with hop", remap = true })
	end,
}
