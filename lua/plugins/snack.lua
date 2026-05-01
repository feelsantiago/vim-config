return {
	"folke/snacks.nvim",
	opts = {
		styles = {
			zen = {
				position = "float",
				backdrop = 60,
				height = 0.9,
				width = 0.9,
				zindex = 50,
				border = true,
			},
		},

		-- picker = { -- Enhances `select()`
		-- 	actions = {
		-- 		opencode_send = function(...)
		-- 			return require("opencode").snacks_picker_send(...)
		-- 		end,
		-- 	},
		-- 	win = {
		-- 		input = {
		-- 			keys = {
		-- 				["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
		-- 			},
		-- 		},
		-- 	},
		-- },
		zen = {
			win = {
				style = "zen",
			},
			zoom = {
				toggles = {},
				center = true,
				show = { statusline = true, tabline = true },
			},
		},
	},
	keys = {
		{
			"<leader>z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Toggle Zoom",
		},
		{
			"<leader>Z",
			function()
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
		},
	},
}
