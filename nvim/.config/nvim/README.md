# Personal Neovim Configuration

A modular, well-organized Neovim configuration built from kickstart.nvim as a starting point, evolved into a personalized setup with plugin-based organization.

## Structure

```
lua/
├── core/
│   ├── init.lua       - Main entry point (lazy.nvim setup)
│   ├── options.lua    - Editor options and settings
│   ├── keymaps.lua     - Global key mappings
│   └── autocmds.lua    - Autocommands
├── plugins/            - Plugin configurations (lazy-loaded)
│   ├── autopairs.lua
│   ├── completion.lua   - blink.cmp + LuaSnip
│   ├── diffview.lua     - Git diff viewer
│   ├── editor.lua       - Comment, conform, guess-indent
│   ├── flutter-tools.lua
│   ├── git.lua         - Gitsigns + Fugitive
│   ├── harpoon.lua      - File marks
│   ├── lsp.lua         - Language servers
│   ├── markdown.lua     - Render markdown
│   ├── sql.lua         - Dadbod database tools
│   ├── telescope.lua    - Fuzzy finder
│   ├── treesitter.lua   - Syntax highlighting
│   ├── ui.lua          - Colorscheme, which-key, statusline, neo-tree
│   └── undotree.lua
└── utils.lua           - Utility functions
```

## Key Features

### Core
- **Modular organization** - Each plugin in its own file
- **Lazy loading** - Plugins load only when needed
- **Type safety** - LSP support via `.luarc.json`
- **Nerd Font support** - Icons throughout the UI

### Editor Features
- **Autocompletion** - blink.cmp with LuaSnip snippets
- **LSP** - Mason + nvim-lspconfig for language servers
- **Syntax highlighting** - Treesitter for better code understanding
- **Git integration** - Gitsigns, Fugitive, and Diffview
- **File navigation** - Telescope fuzzy finder
- **Quick marks** - Harpoon for fast file switching
- **Neo-tree** - File explorer with floating window
- **Auto-formatting** - Conform.nvim with Prettier, stylua
- **Undo tree** - Visual undo history
- **Better comments** - Comment.nvim with toggle support
- **Markdown preview** - Render-markdown for better readability

### Database Support
- **Dadbod** - Database UI and completion for SQL files
- Quick query execution with `<leader>dq`
- Database UI toggle with `<leader>db`

### Keymap Philosophy
- **Global keymaps** in `core/keymaps.lua` for general functionality
- **Plugin keymaps** in plugin files with `keys` field for lazy loading
- **Leader key**: `<space>`
- **Which-key**: Shows available keybindings automatically

## Installation

### Prerequisites

- Neovim 0.10+
- `git`, `make`, `unzip`, `gcc`
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- Clipboard tool: `xclip`/`xsel` (Linux) or built-in (Mac/Windows)
- [Nerd Font](https://www.nerdfonts.com/) (optional but recommended)

### Setup

Clone this repository to your Neovim config directory:

```bash
# Backup existing config if needed
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this config
git clone <your-repo-url> ~/.config/nvim
```

### First Run

Launch Neovim - lazy.nvim will automatically install all plugins:

```bash
nvim
```

Use `:Lazy` to view plugin status and `:Lazy update` to update plugins.

## Plugin Management

All plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim).

- `:Lazy` - Open plugin manager UI
- `:Lazy sync` - Install/update/clean plugins
- `:Lazy update` - Update all plugins
- `:Lazy clean` - Remove unused plugins

## Adding New Plugins

1. Create a new file in `lua/plugins/` (e.g., `newplugin.lua`)
2. Return a plugin spec table:

```lua
return {
  'username/plugin-name',
  keys = { '<leader>kp', '<cmd>PluginCommand<CR>', desc = 'Plugin description' },
  config = function()
    require('plugin-name').setup {
      -- your config
    }
  end,
}
```

3. Lazy will automatically load the plugin

## Key Mappings

### Global
- `<space>` - Leader key
- `<Esc>` - Clear search highlights
- `<C-h/j/k/l>` - Navigate windows
- `<S-h/l>` - Navigate buffers
- `<leader>q` - Quit
- `<leader>w` - Write/save
- `<leader>f` - Format buffer

### Telescope
- `<leader>sf` - Find files
- `<leader>sg` - Live grep
- `<leader>sb` - Buffers
- `<leader>sh` - Help tags
- `<leader>sr` - Resume last search

### Git
- `<leader>gs` - Git status (Fugitive)
- `<leader>gd` - Diffview (working copy)
- `<leader>gH` - File history (repo)
- `<leader>gh` - File history (current)

### Harpoon
- `<leader>a` - Add file to marks
- `<leader>e` - Toggle quick menu
- `<C-e>` - Toggle quick menu
- `<C-h/t/n/s>` - Jump to mark 1/2/3/4

### Database
- `<leader>db` - Toggle DBUI
- `<leader>dq` - Execute query

## Language Support

Configured LSPs (auto-installed via Mason):
- TypeScript/JavaScript - `ts_ls`, `eslint`
- Lua - `lua_ls`
- Go - `gopls` (if `go` is installed)
- C/C++ - `clangd`
- CSS - `cssls`, `tailwindcss`
- JSON - `jsonls`

Formatters:
- JavaScript/TypeScript - `prettier`
- Lua - `stylua`

## Customization

### Modifying Options
Edit `lua/core/options.lua` for editor settings.

### Adding Keymaps
- General keymaps: Add to `lua/core/keymaps.lua`
- Plugin keymaps: Add to the plugin file using the `keys` field

### Platform-Specific Config
Use `utils.lua` helpers:
```lua
if utils.is_linux then
  -- Linux-specific config
end

if utils.is_executable 'command' then
  -- Only if command exists
end
```

## Troubleshooting

### Plugin not loading
- Check `:Lazy` status
- Ensure the plugin file returns a valid spec
- Verify lazy.nvim is syncing: `:Lazy sync`

### LSP not working
- Check `:Mason` to ensure language servers are installed
- Run `:LspInfo` to see active LSP clients
- Restart Neovim after installing servers

### Performance issues
- Use `:Lazy profile` to see startup times
- Check plugin lazy loading with `keys`/`event`/`ft` fields
- Disable unused plugins in `lua/plugins/`

## Resources

- [Neovim documentation](https://neovim.io/doc/)
- [lazy.nvim docs](https://lazy.folke.io/)
- [Lua guide](https://learnxinyminutes.com/docs/lua/)
- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - Original inspiration
