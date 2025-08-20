return {
	"nvim-neo-tree/neo-tree.nvim", 
	branch = "v3.x",
	lazy = false,
    	dependencies = {
      		"nvim-lua/plenary.nvim",
      	 	"MunifTanjim/nui.nvim",
      	 	"nvim-tree/nvim-web-devicons",
    	 }, 
	config = function()
		vim.keymap.set('n', '<C-b>', ':Neotree filesystem reveal left<CR>')
	end
}
