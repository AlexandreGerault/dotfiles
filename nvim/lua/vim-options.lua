vim.cmd 'set expandtab'
vim.cmd 'set tabstop=2'
vim.cmd 'set softtabstop=2'
vim.cmd 'set shiftwidth=2'
vim.g.mapleader = ' '
vim.cmd 'set relativenumber'

-- Providers
-- Python: dedicated venv with pynvim (create with:
--   uv venv ~/.local/share/nvim/python-venv && uv pip install --python ~/.local/share/nvim/python-venv/bin/python pynvim)
local nvim_python = vim.fn.stdpath("data") .. "/python-venv/bin/python"
if vim.uv.fs_stat(nvim_python) then
  vim.g.python3_host_prog = nvim_python
end
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
