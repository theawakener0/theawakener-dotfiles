return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      automatic_installation = true,
      ensure_installed = { "gopls", "clangd", "html", "cssls" },
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

      local gopls_cmd = vim.fn.exepath("gopls")
      if gopls_cmd == "" then
        gopls_cmd = "gopls"
      end

      local servers = {
        ts_ls = {},
        html = {},
        lua_ls = {},
        cssls = {},
        clangd = {},
        pyright = {},
        gopls = { cmd = { gopls_cmd } },
        rust_analyzer = {},
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities
        config.flags = { debounce_text_changes = 200 }
        vim.lsp.config[server] = vim.tbl_deep_extend("force", vim.lsp.config[server] or {}, config)
      end

      vim.diagnostic.config({
        virtual_text = { prefix = '∎', spacing = 2 },
        signs = {
        },
        underline = true,
        update_in_insert = true,
        severity_sort = true,
      })

      vim.lsp.enable("ts_ls", { filetype = { "typescript", "javascript", "typescriptreact", "javascriptreact" } })
      vim.lsp.enable("lua_ls", { filetype = { "lua" } })
      vim.lsp.enable("clangd", { filetype = { "c", "cpp" } })
      vim.lsp.enable("pyright", { filetype = { "python" } })
      vim.lsp.enable("gopls", { filetype = { "go" } })
      vim.lsp.enable("rust_analyzer", { filetype = { "rust" } })
      vim.lsp.enable("html", { filetype = { "html" } })
      vim.lsp.enable("cssls", { filetype = { "css", "scss", "less" } })

      -- Setup LspAttach autocmd for keymaps (modern approach)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        end,
      })
    end,
  },
}
