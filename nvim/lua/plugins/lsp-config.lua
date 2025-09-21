return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
      })
      
      vim.lsp.config("html", {
        capabilities = capabilities,
      })
      
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
      })
      
      vim.lsp.config("cssls", {
        capabilities = capabilities,
      })
      
      vim.lsp.config("clangd", {
        capabilities = capabilities,
      })
      
      vim.lsp.config("pyright", {
        capabilities = capabilities,
      })
      
      vim.lsp.config("gopls", {
        capabilities = capabilities,
      })

      -- Enable LSP servers
      vim.lsp.enable({"ts_ls", "html", "lua_ls", "cssls", "clangd", "pyright", "gopls"})

      -- Setup LspAttach autocmd for keymaps (modern approach)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },
}
