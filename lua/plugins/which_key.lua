local get_icon = require("utils").get_icon

return {
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup({
			win = {
				border = "single", -- none, single, double, shadow
				padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
				zindex = 1000, -- positive value to position WhichKey above other floating windows.
				wo = {
					winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
				},
			},
			layout = {
				height = { min = 4, max = 10 }, -- min and max height of the columns
				width = { min = 10, max = 30 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
				align = "left", -- align columns left, center or right
			},
		})

		-- Document existing key chains
		require("which-key").add({
			{
				{ "<leader>F", group = "󱃖 Flutter Tools", hidden = false },
				{ "<leader>f", group = " Find", hidden = false },
				{ "<leader>g", group = "󰊢 Git", hidden = false },
				{ "<leader>h", group = "󱂬 Harpoon", hidden = false },
				{ "<leader>l", group = " LSP", hidden = false },
				{ "<leader>n", group = "󰅌 Other", hidden = false },
				{ "<leader>p", group = "󰏖 Plugins", hidden = false },
				{ "<leader>s", group = "󰈭 Search/Replace", hidden = false },
				{ "<leader>t", group = " Terminal", hidden = false },
				{ "<leader>u", group = " UI", hidden = false },
				{ "<leader>x", group = "󰒡 Trouble", hidden = false },
			},
		})
	end,
}
