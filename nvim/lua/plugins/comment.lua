return {
	-- Commenting uses Neovim's built-in `gc` / `gcc` + ts-comments.nvim (see web-editing.lua)
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
