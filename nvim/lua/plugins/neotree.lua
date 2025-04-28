return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = { position = "right" },
  },
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function(_, opts)
    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal right<CR>")
    require("neo-tree").setup(opts)
  end,
}
