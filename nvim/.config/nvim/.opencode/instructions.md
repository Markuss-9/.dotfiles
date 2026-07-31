# Neovim config project

This is a Lua Neovim configuration.

Stack:
- lazy.nvim
- nvim-lspconfig
- nvim-treesitter
- mason.nvim
- telescope.nvim

When changing code:
- do not rewrite plugin specs unnecessarily
- preserve existing architecture
- check upstream plugin changes first
- assume migration problems are caused by:
  1. Neovim API changes
  2. plugin update requirements
  3. removed/deprecated APIs
