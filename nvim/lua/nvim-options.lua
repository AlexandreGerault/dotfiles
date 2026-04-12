-- Highlight
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- Indent
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local file_type = vim.bo[args.buf].filetype

    if file_type ~= "c" and file_type ~= "cpp" then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
