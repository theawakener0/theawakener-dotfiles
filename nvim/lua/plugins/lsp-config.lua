return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        flags = { debounce_text_changes = 300 }
      })
      
      vim.lsp.config("html", {
        capabilities = capabilities,
        flags = { debounce_text_changes = 300 }
      })
      
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        flags = { debounce_text_changes = 300 }
      })
      
      vim.lsp.config("cssls", {
        capabilities = capabilities,
        flags = { debounce_text_changes = 300 }
      })
      
      vim.lsp.config("clangd", {
        capabilities = capabilities,
        flags = { debounce_text_changes = 300 }
      })
      
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        flags = { debounce_text_changes = 300 }
      })
      
      vim.lsp.config("gopls", {
        capabilities = capabilities,
        flags = { debounce_text_changes = 300 }
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