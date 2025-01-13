return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "echasnovski/mini.icons" },
		config = function()
			local harpoon = require("harpoon.mark")
			local utils = require("core.utils")

			local function harpoon_component()
				local total_marks = harpoon.get_length()

				if total_marks == 0 then
					return ""
				end

				local current_mark = "—"

				local mark_idx = harpoon.get_current_index()
				if mark_idx ~= nil then
					current_mark = tostring(mark_idx)
				end

				return string.format("󱡅 %s/%d", current_mark, total_marks)
			end

			local filetype_map = {
				lazy = { name = "lazy.nvim", icon = "💤" },
				minifiles = { name = "minifiles", icon = "🗂️ " },
				snacks_terminal = { name = "terminal", icon = "🐚" },
				mason = { name = "mason", icon = "🔨" },
				TelescopePrompt = { name = "telescope", icon = "🔍" },
			}

			require("lualine").setup({
				options = {
					component_separators = { left = " ", right = " " },
					section_separators = { left = " ", right = " " },
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "alpha" } },
				},
				sections = {
					lualine_a = {
						{
							"mode",
							icon = "",
							fmt = function(mode)
								return mode:lower()
							end,
						},
					},
					lualine_b = { { "branch", icon = "" }, harpoon_component },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = " ",
								warn = " ",
								info = " ",
								hint = "󰝶 ",
							},
						},
						{
							function()
								local devicons = require("nvim-web-devicons")
								local ft = vim.bo.filetype
								local icon
								if filetype_map[ft] then
									return " " .. filetype_map[ft].icon
								end
								if icon == nil then
									icon = devicons.get_icon(vim.fn.expand("%:t"))
								end
								if icon == nil then
									icon = devicons.get_icon_by_filetype(ft)
								end
								if icon == nil then
									icon = " 󰈤"
								end

								return icon .. " "
							end,
							color = function()
								local _, hl = require("nvim-web-devicons").get_icon(vim.fn.expand("%:t"))
								if hl then
									return hl
								end
								return utils.get_hlgroup("Normal")
							end,
							separator = "",
							padding = { left = 0, right = 0 },
						},
						{
							"filename",
							padding = { left = 0, right = 0 },
							fmt = function(name)
								if filetype_map[vim.bo.filetype] then
									return filetype_map[vim.bo.filetype].name
								else
									return name
								end
							end,
						},
						{
							function()
								local buffer_count = require("core.utils").get_buffer_count()

								return "+" .. buffer_count - 1 .. " "
							end,
							cond = function()
								return require("core.utils").get_buffer_count() > 1
							end,
							color = utils.get_hlgroup("Operator", nil),
							padding = { left = 0, right = 1 },
						},
						{
							function()
								local tab_count = vim.fn.tabpagenr("$")
								if tab_count > 1 then
									return vim.fn.tabpagenr() .. " of " .. tab_count
								end
							end,
							cond = function()
								return vim.fn.tabpagenr("$") > 1
							end,
							icon = "󰓩",
							color = utils.get_hlgroup("Special", nil),
						},
						{
							function()
								return require("nvim-navic").get_location()
							end,
							cond = function()
								return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
							end,
							color = utils.get_hlgroup("Comment", nil),
						},
					},
					lualine_x = {
						{
							---@diagnostic disable: undefined-field
							require("noice").api.status.mode.get,
							cond = function()
								local ignore = {
									"-- INSERT --",
									"-- TERMINAL --",
									"-- VISUAL --",
									"-- VISUAL LINE --",
									"-- VISUAL BLOCK --",
								}
								local mode = require("noice").api.status.mode.get()
								return require("noice").api.status.mode.has() and not vim.tbl_contains(ignore, mode)
							end,
							color = utils.get_hlgroup("Comment"),
							---@diagnostic enable: undefined-field
						},
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = utils.get_hlgroup("String"),
						},
						{
							function()
								local icon = " "
								local status = require("copilot.api").status.data
								return icon .. (status.message or "")
							end,
							cond = function()
								local ok, clients = pcall(vim.lsp.get_clients, { name = "copilot", bufnr = 0 })
								return ok and #clients > 0
							end,
							color = function()
								if not package.loaded["copilot"] then
									return
								end
								local status = require("copilot.api").status.data
								return copilot_colors[status.status] or copilot_colors[""]
							end,
						},
						{ "diff" },
					},
					lualine_y = {
						{
							"progress",
						},
						{
							"location",
							color = utils.get_hlgroup("Boolean"),
						},
					},
					lualine_z = {
						{
							"datetime",
							style = "  %X",
						},
					},
				},
			})
		end,
	},
}
