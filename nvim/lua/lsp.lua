-- Server-specific settings (merged on top of nvim-lspconfig's lsp/*.lua defaults)
local ts_inlay_hints = {
	parameterNames = { enabled = "literals" },
	parameterTypes = { enabled = true },
	variableTypes = { enabled = false },
	propertyDeclarationTypes = { enabled = true },
	functionLikeReturnTypes = { enabled = true },
	enumMemberValues = { enabled = true },
}

vim.lsp.config("vtsls", {
	settings = {
		complete_function_calls = true,
		vtsls = {
			enableMoveToFileCodeAction = true,
			autoUseWorkspaceTsdk = true, -- use the project's typescript version
			experimental = {
				completion = { enableServerSideFuzzyMatch = true },
			},
		},
		typescript = {
			updateImportsOnFileMove = { enabled = "always" },
			suggest = { completeFunctionCalls = true },
			inlayHints = ts_inlay_hints,
		},
		javascript = {
			updateImportsOnFileMove = { enabled = "always" },
			inlayHints = ts_inlay_hints,
		},
	},
})

vim.lsp.config("jsonls", {
	before_init = function(_, config)
		config.settings.json.schemas = require("schemastore").json.schemas()
	end,
	settings = {
		json = {
			validate = { enable = true },
		},
	},
})

vim.lsp.enable("biome")
vim.lsp.enable("clangd")
vim.lsp.enable("gopls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("yamlls")
vim.lsp.enable("vtsls")
vim.lsp.enable("eslint")
vim.lsp.enable("cssls")
vim.lsp.enable("html")
vim.lsp.enable("jsonls")
vim.lsp.enable("emmet_language_server")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("pylsp")
vim.lsp.enable("jls")

vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
-- <leader>gf (format) is defined in plugins/conform.lua
vim.keymap.set("n", "<leader>?", vim.diagnostic.open_float, {})

-- Inlay hints: on by default, <leader>ih to toggle
vim.lsp.inlay_hint.enable(true)
vim.keymap.set("n", "<leader>ih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

vim.diagnostic.config({ virtual_text = true })
