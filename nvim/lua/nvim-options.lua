-- Treesitter highlight + indent, only where a parser is available
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if not pcall(vim.treesitter.start, args.buf) then
      return -- no parser: keep Neovim's built-in indent for this filetype
    end

    local file_type = vim.bo[args.buf].filetype
    if file_type ~= "c" and file_type ~= "cpp" then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
