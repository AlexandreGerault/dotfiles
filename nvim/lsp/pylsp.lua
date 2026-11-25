---@brief
---
--- https://github.com/python-lsp/python-lsp-server
---
--- A Python 3.6+ implementation of the Language Server Protocol.
---
--- See the [project's README](https://github.com/python-lsp/python-lsp-server) for installation instructions.
---
--- Configuration options are documented [here](https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md).
--- In order to configure an option, it must be translated to a nested Lua table and included in the `settings` argument to the `config('pylsp', {})` function.
--- For example, in order to set the `pylsp.plugins.pycodestyle.ignore` option:
--- ```lua
--- vim.lsp.config('pylsp', {
---   settings = {
---     pylsp = {
---       plugins = {
---         pycodestyle = {
---           ignore = {'W391'},
---           maxLineLength = 100
---         }
---       }
---     }
---   }
--- })
--- ```
---
--- Note: This is a community fork of `pyls`.

---@type vim.lsp.Config
return {
  cmd = { 'pylsp' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  -- pylsp runs from Mason's own venv: point jedi at the project's venv so
  -- completion / goto-definition resolve the project's installed packages.
  on_init = function(client)
    local venv = vim.env.VIRTUAL_ENV
    if not venv and client.root_dir then
      for _, name in ipairs({ '.venv', 'venv' }) do
        local candidate = vim.fs.joinpath(client.root_dir, name)
        if vim.uv.fs_stat(vim.fs.joinpath(candidate, 'bin', 'python')) then
          venv = candidate
          break
        end
      end
    end
    if venv then
      client.settings = vim.tbl_deep_extend('force', client.settings or {}, {
        pylsp = { plugins = { jedi = { environment = venv } } },
      })
      client:notify('workspace/didChangeConfiguration', { settings = client.settings })
    end
  end,
}
