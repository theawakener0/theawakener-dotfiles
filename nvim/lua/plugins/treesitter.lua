return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				-- Add more common languages (adjust as needed)
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



