return {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
        local ok, null_ls = pcall(require, 'null-ls')
        if not ok then return end

        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics

        local sources = {
            formatting.prettier.with({ filetypes = { "javascript", "typescript", "html", "css", "json" } }),
            formatting.black.with({ extra_args = { "--fast" } }),
            diagnostics.eslint,
        }

        null_ls.setup({
            sources = sources,
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = 0, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
                    })
                end
            end,
        })
    end
}
