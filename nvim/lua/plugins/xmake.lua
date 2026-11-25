return {
	{
		"Mythos-404/xmake.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("xmake").setup({
				-- optional tweaks
				ui = {
					border = "rounded",
				},
			})

			-- Keymaps
			vim.keymap.set("n", "<leader>xs", "<cmd>Xmake select_target<CR>")
			vim.keymap.set("n", "<leader>xb", "<cmd>Xmake build<CR>")
			vim.keymap.set("n", "<leader>xr", "<cmd>Xmake run<CR>")
		end,
	},
}
