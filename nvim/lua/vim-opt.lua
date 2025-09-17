vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.relativenumber = true
vim.opt.number = true

vim.keymap.set("n", "<leader>e", ":Ex<CR>", { silent = true, desc = "Explorer (Ex)" })

