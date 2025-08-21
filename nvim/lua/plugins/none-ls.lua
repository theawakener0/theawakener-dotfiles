local plugin_spec = {
  {
    "nvimtools/none-ls.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local ok, none_ls = pcall(require, "none-ls")
      if not ok then
        return
      end

      local formatting = none_ls.builtins.formatting
      local diagnostics = none_ls.builtins.diagnostics
      local code_actions = none_ls.builtins.code_actions

      none_ls.setup({
        debounce = 150,
        save_after_format = false,
        sources = {
          formatting.prettier.with({ extra_args = { "--no-semi" } }),
          diagnostics.eslint.with({ diagnostics_format = "#{m} [eslint]" }),
          formatting.black.with({ extra_args = { "--fast" } }),
          formatting.stylua,
          formatting.gofmt,
          code_actions.refactoring,
        },
      })
    end,
  },
}

return plugin_spec