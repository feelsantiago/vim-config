return {
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = true,
				},
			})
		end,
	},
	-- {
	-- 	"windwp/nvim-autopairs",
	-- 	config = function()
	-- 		require("nvim-autopairs").setup()
	-- 	end,
	-- },
	{
		"xzbdmw/colorful-menu.nvim",
	},
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "*",
		lazy = false,
		opts = {
			completion = {
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
				menu = {
					auto_show = function(ctx)
						return ctx.mode ~= "cmdline"
					end,
					border = "single",
					draw = {
						columns = { { "provider" }, { "kind_icon" }, { "label", gap = 1 }, { "kind" } },
						components = {
							label = {
								width = { fill = true, max = 110 },
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
							provider = {
								text = function(ctx)
									return "[" .. ctx.item.source_name:sub(1, 3):upper() .. "]"
								end,
								highlight = "BlinkCmpGhostText",
							},
						},
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
					window = { border = "single" },
				},
				ghost_text = { enabled = false },
			},
			keymap = {
				preset = "enter",
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
			},
			signature = { window = { border = "single" } },
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
				kind_icons = {
					Array = " ",
					Boolean = "󰨙 ",
					Class = " ",
					Codeium = "󰘦 ",
					Color = " ",
					Control = " ",
					Collapsed = " ",
					Constant = "󰏿 ",
					Constructor = " ",
					Copilot = " ",
					Enum = " ",
					EnumMember = " ",
					Event = " ",
					Field = " ",
					File = " ",
					Folder = " ",
					Function = "󰊕 ",
					Interface = " ",
					Key = " ",
					Keyword = " ",
					Method = "󰊕 ",
					Module = " ",
					Namespace = "󰦮 ",
					Null = " ",
					Number = "󰎠 ",
					Object = " ",
					Operator = " ",
					Package = " ",
					Property = " ",
					Reference = " ",
					Snippet = "󱄽 ",
					String = " ",
					Struct = "󰆼 ",
					Supermaven = " ",
					TabNine = "󰏚 ",
					Text = " ",
					TypeParameter = " ",
					Unit = " ",
					Value = " ",
					Variable = "󰀫 ",
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
		opts_extend = {
			"sources.completion.enabled_providers",
			"sources.default",
		},
	},
}
