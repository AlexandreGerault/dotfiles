return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "biome",
          "clangd",
          "docker_compose_language_service",
          "dockerls",
          "eslint",
          "gopls",
          "lua_ls",
          "rust_analyzer",
          "tailwindcss",
          "ts_ls",
          "yamlls"
        },
      })
    end,
  },
}
