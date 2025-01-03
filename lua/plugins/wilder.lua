return {
	{
		"gelguy/wilder.nvim",
		keys = {
			":",
			"/",
			"?",
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local wilder = require("wilder")

			-- Enable wilder when pressing :, / or ?
			wilder.setup({ modes = { ":", "/", "?" } })

			-- Enable fuzzy matching for commands and buffers
			wilder.set_option("pipeline", {
				wilder.branch(
					wilder.cmdline_pipeline({
						fuzzy = 1,
					}),
					wilder.vim_search_pipeline({
						fuzzy = 1,
					})
				),
				wilder.result_draw_devicons(),
			})

			wilder.set_option(
				"renderer",
				wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
					highlighter = wilder.basic_highlighter(),
					border = "rounded",
					prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
					reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
					left = { " ", wilder.popupmenu_devicons() },
					right = { " ", wilder.popupmenu_scrollbar() },
				}))
			)
		end,
	},
}
