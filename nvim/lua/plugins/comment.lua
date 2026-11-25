return {
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("neogen").setup({})
		end,
		keys = {
			{
				"<leader>nf",
				function()
					require("neogen").generate()
				end,
				desc = "Generate annotation (Neogen)",
			},
		},
	},
}
