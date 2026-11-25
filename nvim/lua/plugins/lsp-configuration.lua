return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()

			-- Packages not mapped by mason-lspconfig
			local registry = require("mason-registry")
			registry.refresh(function()
				for _, name in ipairs({ "jls", "prettierd" }) do
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
				-- ts_ls is replaced by vtsls; excluded in case it is still installed
				automatic_enable = { exclude = { "ts_ls" } },
				ensure_installed = {
					"biome",
					"clangd",
					"cssls",
					"docker_compose_language_service",
					"dockerls",
					"emmet_language_server",
					"eslint",
					"gopls",
					"html",
					"jsonls",
					"lua_ls",
					"pylsp",
					"rust_analyzer",
					"tailwindcss",
					"vtsls",
					"yamlls",
				},
			})
		end,
	},
}
