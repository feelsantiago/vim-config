return {
	"kkoomen/vim-doge",
	event = "BufRead",
	config = function()
		vim.cmd([[call doge#install()]])

		vim.g.doge_enable_mappings = 0

		-- Generate comment for current line
		vim.keymap.set("n", "<leader>ld", "<cmd>DogeGenerate<cr>")
	end,
}
