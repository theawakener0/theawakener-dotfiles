local M = {}

M.on_attach = function(client, bufnr)
  local map = function(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc }) end

  map('n', 'gd', vim.lsp.buf.definition, 'LSP: go to definition')
  map('n', 'K', vim.lsp.buf.hover, 'LSP: hover')
  map({'n','v'}, '<leader>ca', vim.lsp.buf.code_action, 'LSP: code action')

  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
    })
  end
end

return M
