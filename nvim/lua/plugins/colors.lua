return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		local transparent = vim.g.theawakener_transparent or false
		require('catppuccin').setup({
			flavour = "mocha",
			integrations = {
				lsp_trouble = true,
				lualine = true,
				treesitter = true,
			},
			transparent_background = transparent,
		})
		vim.cmd.colorscheme "catppuccin"
	end
}
