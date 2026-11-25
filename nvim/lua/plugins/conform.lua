-- Formatting: one formatter per filetype instead of every attached LSP.
-- JS/TS/CSS/JSON use biome when the project has a biome config, prettier otherwise.
-- conform prefers the project's node_modules/.bin binaries over the Mason ones.
local function biome_or_prettier(bufnr)
	if vim.fs.root(bufnr, { "biome.json", "biome.jsonc", ".biome.json", ".biome.jsonc" }) then
		return { "biome" }
	end
	return { "prettierd", "prettier", stop_after_first = true }
end

local web_filetypes = {
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"vue",
	"svelte",
	"astro",
	"css",
	"scss",
	"less",
	"html",
	"json",
	"jsonc",
	"graphql",
	"markdown",
	"yaml",
}

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>gf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},
	opts = function()
		local formatters_by_ft = {
			lua = { "stylua" },
		}
		for _, ft in ipairs(web_filetypes) do
			formatters_by_ft[ft] = biome_or_prettier
		end
		return {
			formatters_by_ft = formatters_by_ft,
		}
	end,
}
