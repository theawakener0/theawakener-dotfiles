return {
    {
        -- Official repo is now 'williamboman/mason.nvim'
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end
    },
    {
        -- Official companion plugin
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        dependencies = { "williamboman/mason.nvim" },
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
        dependencies = { 
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp"
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require('lsp').capabilities
            local base_on_attach = require('lsp').on_attach

            local function on_attach(client, bufnr)
                if client.name == "ts_ls" or client.name == "tsserver" or client.name == "lua_ls" then
                    if client.server_capabilities then
                        client.server_capabilities.documentFormattingProvider = false
                        client.server_capabilities.documentRangeFormattingProvider = false
                    end
                end
                base_on_attach(client, bufnr)
            end

            -- Lua language server settings for Neovim
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        diagnostics = { globals = { 'vim' } },
                        workspace = { library = vim.api.nvim_get_runtime_file('', true) },
                        telemetry = { enable = false },
                    },
                },
            })

            lspconfig.ts_ls.setup({ capabilities = capabilities, on_attach = on_attach })
            lspconfig.clangd.setup({ capabilities = capabilities, on_attach = on_attach })
            lspconfig.pyright.setup({ capabilities = capabilities, on_attach = on_attach })
            lspconfig.gopls.setup({ capabilities = capabilities, on_attach = on_attach })
        end
    }

}

