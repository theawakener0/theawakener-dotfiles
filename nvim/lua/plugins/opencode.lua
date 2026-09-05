return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  dependencies = {
    "folke/snacks.nvim",
  },
  config = function()
    vim.o.autoread = true

    vim.g.opencode_opts = {
      ask = {
        snacks = {
          icon = "󰚩 ",
          win = {
            title_pos = "left",
            relative = "cursor",
            row = -3,
            col = 0,
          },
        },
      },
    }

    vim.keymap.set({ "n", "x" }, "<leader>oa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode…" })

    vim.keymap.set({ "n", "x" }, "<leader>os", function()
      require("opencode").select()
    end, { desc = "Execute opencode action…" })

    vim.keymap.set({ "n", "t" }, "<leader>ot", function()
      require("opencode").toggle()
    end, { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "<leader>og", function()
      return require("opencode").operator("@this ")
    end, { desc = "Add range to opencode", expr = true })
  end,
}
