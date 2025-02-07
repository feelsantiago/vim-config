vim.api.nvim_create_autocmd("FileType", {
	pattern = "oil",
	callback = function()
		vim.opt_local.colorcolumn = ""
	end,
})

return {
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				use_default_keymaps = false,
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["S"] = "actions.select_split",
					["s"] = "actions.select_vsplit", -- this is used to navigate left
					["<C-t>"] = "actions.select_tab",
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["<C-r>"] = "actions.refresh",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["H"] = "actions.toggle_hidden",
				},
				view_options = {
					show_hidden = true,
					-- is_hidden_file = function(name, bufnr)
					-- 	return (vim.startswith(name, ".") or string.find(name, ".g."))
					-- 		and not vim.startswith(name, "..")
					-- end,
				},
				float = {
					win_options = {
						winblend = 0,
					},
				},
			})

			-- Map Oil to <leader>e
			vim.keymap.set("n", "<leader>e", function()
				require("oil").toggle_float()
			end, { desc = "Open File Explorer" })
		end,
	},
}
