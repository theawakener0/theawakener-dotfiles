return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  keys = {
    { "<c-h>", "<cmd>TmuxNavigateLeft<CR>", desc = "Navigate left" },
    { "<c-j>", "<cmd>TmuxNavigateDown<CR>", desc = "Navigate down" },
    { "<c-k>", "<cmd>TmuxNavigateUp<CR>", desc = "Navigate up" },
    { "<c-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate right" },
    { "<c-\\>", "<cmd>TmuxNavigatePrevious<CR>", desc = "Navigate previous" },
    -- Terminal mode mappings
    { mode = "t", "<c-h>", "<C-w><cmd>TmuxNavigateLeft<CR>", desc = "Navigate left" },
    { mode = "t", "<c-j>", "<C-w><cmd>TmuxNavigateDown<CR>", desc = "Navigate down" },
    { mode = "t", "<c-k>", "<C-w><cmd>TmuxNavigateUp<CR>", desc = "Navigate up" },
    { mode = "t", "<c-l>", "<C-w><cmd>TmuxNavigateRight<CR>", desc = "Navigate right" },
    { mode = "t", "<c-\\>", "<C-w><cmd>TmuxNavigatePrevious<CR>", desc = "Navigate previous" },
  },
}
