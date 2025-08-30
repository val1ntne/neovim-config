# neovim-config
My neovim config that uses Lazy nvim and optimzed for full-stack development.May have some errors though
# Full-Stack Web Development Neovim Configuration

A complete, modern Neovim configuration designed specifically for full-stack web development. This setup provides an IDE-like experience with powerful features for JavaScript, TypeScript, Python, and more.

## Features

### Core IDE Features
- **LSP Support** - Auto-completion, diagnostics, and formatting for all major web technologies
- **Advanced File Explorer** - NvimTree with Git integration and file operations
- **Fuzzy Finding** - Telescope for files, strings, buffers, and more
- **Syntax Highlighting** - TreeSitter for accurate, fast syntax highlighting
- **Auto-completion** - nvim-cmp with snippets and multiple sources
- **Debugging** - DAP support for Node.js, Python, and other languages

### Web Development Specific
- **Live Server** - Real-time preview for HTML/CSS/JS development
- **REST Client** - Test APIs directly from Neovim
- **Package Management** - npm package.json integration with version info
- **Emmet Support** - Fast HTML/CSS coding with abbreviations
- **Color Highlighting** - Visual CSS color preview
- **Database Integration** - Connect and query databases

### Git Integration
- **Gitsigns** - Inline git blame, diff, and staging
- **Fugitive** - Full Git workflow integration
- **Diffview** - Advanced diff and merge conflict resolution

### Developer Experience
- **Which-Key** - Discoverable keybinding system
- **Smart Formatting** - Auto-format on save with Conform.nvim
- **Linting** - Real-time code analysis with nvim-lint
- **Project Management** - Automatic project detection and switching
- **Session Management** - Restore your workspace state
- **Terminal Integration** - Floating and split terminals

## Supported Languages & Frameworks

### Frontend
- JavaScript/TypeScript
- React (JSX/TSX)
- Vue.js
- Svelte
- Astro
- HTML/CSS/SCSS
- Tailwind CSS

### Backend
- Node.js
- Python
- PHP
- Go
- Rust

### Databases & APIs
- SQL
- GraphQL
- REST APIs
- Prisma

### Configuration & Data
- JSON/YAML
- Docker
- Markdown

## Installation

### Prerequisites

Install these external tools for full functionality:

```bash
# Required tools
brew install ripgrep fd git node python
# or on Linux:
# sudo apt install ripgrep fd-find git nodejs python3 python3-pip

# Optional but recommended
npm install -g prettier eslint typescript
pip install black isort pylint
```

### Install Configuration

1. **Backup existing config** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this configuration**:
   ```bash
   git clone https://github.com/val1ntne/neovim-config.git ~/.config/nvim
   ```

3. **Start Neovim and install plugins**:
   ```bash
   nvim
   ```
   Lazy.nvim will automatically install all plugins on first startup.

4. **Install language servers**:
   Open Neovim and run `:Mason` to install additional language servers as needed.

## Key Bindings

The leader key is set to `<Space>`. Here are the main keybindings:

### File Operations
- `<leader>ee` - Toggle file explorer
- `<leader>ff` - Find files
- `<leader>fs` - Find string in project
- `<leader>fr` - Recent files
- `<leader>fb` - Find buffers

### LSP & Code
- `gd` - Go to definition
- `gr` - Show references
- `K` - Show documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>mp` - Format file

### Git
- `<leader>gs` - Git status
- `<leader>gd` - Open diff view
- `<leader>gb` - Git blame
- `<leader>hp` - Preview hunk
- `<leader>hs` - Stage hunk

### Terminal & Development
- `<C-\>` - Toggle floating terminal
- `<leader>ls` - Start live server
- `<leader>rr` - Run REST request
- `<leader>db` - Toggle breakpoint

### Window Management
- `<C-h/j/k/l>` - Navigate windows
- `<leader>sv` - Split vertically
- `<leader>sh` - Split horizontally

### Discover More
Press `<Space>` and wait to see all available keybindings with descriptions.

## Configuration Structure

The configuration is contained in a single `init.lua` file with these main sections:

- **Basic Options** - Vim settings and preferences
- **Plugin Management** - Lazy.nvim plugin specifications
- **LSP Configuration** - Language server setup for all supported languages
- **Keymaps** - All custom key bindings
- **Autocommands** - Automatic behaviors and file type detection
- **Custom Commands** - Utility commands for development workflow

## Customization

### Adding Languages
To add support for a new language:

1. Add the language server to the `ensure_installed` list in mason-lspconfig
2. Add formatting rules to conform.nvim configuration
3. Add any language-specific plugins to the lazy.nvim spec

### Changing Theme
The default theme is Catppuccin Mocha. To change it:

1. Replace the catppuccin plugin specification with your preferred theme
2. Update the `vim.cmd.colorscheme()` call
3. Adjust integration settings as needed

### Custom Keybindings
Add your custom keybindings in the keymaps section using:
```lua
vim.keymap.set('n', '<leader>custom', '<cmd>YourCommand<cr>', { desc = 'Description' })
```

## Performance

This configuration is optimized for performance with:
- Lazy loading of plugins
- Minimal startup time (typically < 50ms)
- Efficient TreeSitter parsing
- Smart autocommands that only run when needed

## Troubleshooting

### Common Issues

1. **Slow startup** - Run `:Lazy profile` to identify slow plugins
2. **LSP not working** - Check `:LspInfo` and `:Mason` for server status
3. **Formatting not working** - Verify formatters are installed via `:Mason`
4. **Terminal colors** - Ensure your terminal supports true color

### Getting Help

- Use `:checkhealth` to diagnose configuration issues
- Press `<Space>` to see available keybindings
- Check `:Lazy` for plugin status
- Use `:Mason` to manage language servers and tools

## Contributing

Feel free to submit issues and pull requests. When contributing:

1. Test changes with a clean Neovim installation
2. Update documentation for any new features
3. Follow the existing code style and organization
4. Add appropriate error handling

## License

This configuration is provided as-is for educational and personal use. Individual plugins maintain their own licenses.

---

Built for developers who want a powerful, modern editing experience without the complexity of a full IDE. Happy coding!
