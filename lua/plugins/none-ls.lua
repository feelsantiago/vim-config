return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        -- require("none-ls.code_actions.eslint"),
        -- require("none-ls.diagnostics.eslint_d"),
      },
      debug = true,
    })

    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format file" })
    vim.keymap.set("v", "<leader>lf", vim.lsp.buf.format, { desc = "Format file" })
  end,
}
