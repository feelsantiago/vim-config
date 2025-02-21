return {
	"kazhala/close-buffers.nvim",
	config = function()
		require("close_buffers").setup()

		-- keymaps
		vim.keymap.set("n", "<leader>bd", function()
			require("close_buffers").delete({ type = "hidden", force = true })
		end, { desc = "Delete all non-visible buffers" })

		vim.keymap.set("n", "<leader>bn", function()
			require("close_buffers").delete({ type = "nameless" })
		end, { desc = "Delete all buffers without name" })

		vim.keymap.set("n", "<leader>bc", function()
			require("close_buffers").delete({ type = "this" })
		end, { desc = "Delete the current buffer" })

		vim.keymap.set("n", "<leader>ba", function()
			require("close_buffers").wipe({ type = "all", force = true })
		end, { desc = "Wipe all buffers" })

		vim.keymap.set("n", "<leader>bo", function()
			require("close_buffers").wipe({ type = "other" })
		end, { desc = "Wipe all buffers except the current focused" })
	end,
}
