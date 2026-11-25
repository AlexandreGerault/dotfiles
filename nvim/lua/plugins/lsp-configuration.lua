return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()

			-- Packages not mapped by mason-lspconfig
			local registry = require("mason-registry")
			registry.refresh(function()
				for _, name in ipairs({ "jls" }) do
					local ok, pkg = pcall(registry.get_package, name)
					if ok and not pkg:is_installed() then
						pkg:install()
					end
				end
			end)
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		lazy = false,
		-- nvim-lspconfig provides the lsp/*.lua configs that automatic_enable relies on
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				automatic_enable = true,
				ensure_installed = {
					"biome",
					"clangd",
					"docker_compose_language_service",
					"dockerls",
					"eslint",
					"gopls",
					"lua_ls",
					"pylsp",
					"rust_analyzer",
					"tailwindcss",
					"ts_ls",
					"yamlls",
				},
			})
		end,
	},
}
