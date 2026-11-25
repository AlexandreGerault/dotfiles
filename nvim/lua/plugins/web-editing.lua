return {
	-- Auto close / auto rename HTML and JSX tags
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
	-- Context-aware commentstring for the built-in `gc` (e.g. {/* */} inside JSX)
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		opts = {},
	},
	-- JSON schemas for jsonls (package.json, tsconfig.json, ...)
	{
		"b0o/SchemaStore.nvim",
		lazy = true,
		version = false,
	},
}
