---@brief
---
--- https://github.com/idelice/jls
---
--- Java language server using the Java compiler API, optimized for Neovim.
--- Fork of georgewfraser/java-language-server. Installed through Mason (`:MasonInstall jls`).
---
--- Project-specific settings can be placed in a `jls.json` file at the project root.

---@type vim.lsp.Config
return {
  cmd = { 'jls' },
  filetypes = { 'java' },
  root_markers = {
    'pom.xml',
    'build.gradle',
    'build.gradle.kts',
    'settings.gradle',
    'settings.gradle.kts',
    'BUILD',
    'WORKSPACE',
    '.git',
  },
}
