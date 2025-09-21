return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = {
					"c", "cpp", "javascript", "lua", "python" 
				},
				auto_install = true, -- install missing parsers when entering buffer
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	}
}



