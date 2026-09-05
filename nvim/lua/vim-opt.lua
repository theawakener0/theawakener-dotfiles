vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.opt.formatoptions:remove("t")

vim.opt.updatetime = 300


vim.keymap.set("n", "<leader>e", ":Ex<CR>", { silent = true, desc = "Explorer (Ex)" })
