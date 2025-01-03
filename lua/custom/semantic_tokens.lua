-- turns off LSP semantic tokens by default to integrate with Nord theme
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local isOil = vim.bo.filetype == "oil"
    if not isOil then
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})
