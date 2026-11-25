return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  init = function()
    local ensureInstalled = {
      "lua", "c", "cpp", "php", "rust", "go", "sql", "python",
      -- web
      "javascript", "typescript", "tsx", "jsdoc", "json", "html", "css", "scss",
    }
    local parsersToInstall = vim
        .iter(ensureInstalled)
        :totable()
    require("nvim-treesitter").install(parsersToInstall)
  end,
}
