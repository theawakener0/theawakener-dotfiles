return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		require('catppuccin').setup({
			flavour = "mocha",
			integrations = {
				lsp_trouble = true,
				lualine = true,
				treesitter = true,
			},
			transparent_background = true,
		})
		vim.cmd.colorscheme "catppuccin"
	end
}
