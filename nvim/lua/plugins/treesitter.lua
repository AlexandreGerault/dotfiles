return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  init = function()
    local ensureInstalled = { "lua", "javascript", "c", "cpp", "php", "rust", "go", "sql" }
    local parsersToInstall = vim
        .iter(ensureInstalled)
        :totable()
    require("nvim-treesitter").install(parsersToInstall)
  end,
}
