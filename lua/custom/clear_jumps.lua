vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("clear_jumps", { clear = true }),
  pattern = "*",
  desc = "Clear jump list on start",
  callback = function()
    vim.cmd("clearjumps")
  end,
})
