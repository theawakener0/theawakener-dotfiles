return {
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "clangd",
                    "pyright",
                    "gopls"
                },
                automatic_enable = false
            })
        end
    },
    {
        "https://github.com/neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local on_attach = require('lsp').on_attach
            lspconfig.lua_ls.setup({capabilities = capabilities, on_attach = on_attach})
            lspconfig.ts_ls.setup({capabilities = capabilities, on_attach = on_attach})
            lspconfig.clangd.setup({capabilities = capabilities, on_attach = on_attach})
            lspconfig.pyright.setup({capabilities = capabilities, on_attach = on_attach})
            lspconfig.gopls.setup({capabilities = capabilities, on_attach = on_attach})
        end
    }

}

