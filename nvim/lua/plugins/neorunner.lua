return {
  "theawakener0/NeoRunner",
  cmd = { "NeoRun", "NeoBuild", "NeoClose", "NeoTermResize", "NeoClearCache" },
  config = function()
    require("neorunner").setup({
      term = {
        size = 15,
        position = "bottom",
      },
    })
  end,
  keys = {
    { "<leader>rr", ":NeoRun<CR>", desc = "Run code" },
    { "<leader>rb", ":NeoBuild<CR>", desc = "Build code" },
    { "<leader>rc", ":NeoClose<CR>", desc = "Close terminal" },
  },
}
