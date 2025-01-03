return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm", "TermExec" },
  opts = {
    size = 10,
    on_create = function(t)
      vim.opt.foldcolumn = "0"
      vim.opt.signcolumn = "no"
      local toggle = function()
        t:toggle()
      end
      vim.keymap.set({ "n", "t", "i" }, "<C-'>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
      vim.keymap.set({ "n", "t", "i" }, "<F7>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
    end,
    shading_factor = 2,
    direction = "float",
    float_opts = {
      border = "rounded",
      winblend = 0,
    },
  },
}
