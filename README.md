# Personal Neovim Configuration with nvf

This is my personal Neovim configuration built using [nvf](https://github.com/notashelf/nvf), a highly modular and configurable Neovim configuration framework for Nix users.

## Overview

This flake provides a fully-featured Neovim setup optimized for modern development workflows, with particular emphasis on:

- Web development (PHP, TypeScript, JavaScript, HTML, CSS)
- Infrastructure as Code (Nix, Terraform, HCL)
- Systems programming (Go, Zig, C/C++)
- Scripting (Python, Bash, Nushell)
- Laravel development with specialized tooling

## Features

### Language Support

- **PHP**: Full LSP support with Intelephense, Laravel-specific tooling, Pest testing framework
- **TypeScript/JavaScript**: Complete development environment with error translation
- **Web Technologies**: HTML, CSS, Tailwind CSS support
- **Infrastructure**: Nix, Terraform, HCL support
- **Systems**: Go, Zig, C/C++ with debugging capabilities
- **Scripting**: Python, Bash, Nushell
- **Documentation**: Markdown with live preview
- **Data**: SQL support

### Development Tools

- **LSP**: Comprehensive language server protocol support with trouble diagnostics
- **Completion**: Smart autocompletion with nvim-cmp
- **Debugging**: Full DAP (Debug Adapter Protocol) support with UI
- **Testing**: Integrated testing with Neotest and specialized Pest adapter
- **Git Integration**: Fugitive, GitSigns, conflict resolution, and GitLinker
- **File Management**: NvimTree with git integration and file highlighting
- **Project Management**: Project.nvim for workspace management
- **Search**: Telescope for fuzzy finding with hidden file support

### UI & Experience

- **Theme**: Modern interface with proper borders and icons
- **Navigation**: Harpoon for quick file switching, breadcrumbs, aerial outline
- **Visual Enhancements**:
  - Indent guides and scrollbar
  - Syntax highlighting with Treesitter
  - Cursorline and cursorword highlighting
  - Smart column indicators
- **Notifications**: Integrated notification system
- **Dashboard**: Welcome screen with quick actions
- **Terminal**: Integrated terminal with LazyGit support

### AI & Productivity

- **GitHub Copilot**: AI-powered code completion and suggestions
- **Avante.nvim**: Advanced AI assistant with Claude integration
- **Wakatime**: Development time tracking
- **Snippet Management**: LuaSnip for code snippets
- **Formatting**: Conform.nvim with PHP Pint integration

### Specialized Plugins

- **Laravel.nvim**: Laravel-specific commands and navigation
- **Neotest-Pest**: PHP Pest testing framework integration
- **Snacks.nvim**: Enhanced file explorer and utilities

## Installation

### Using the Flake Directly

```bash
# Run Neovim with this configuration
nix run github:viicslen/nvf-config
```

### Integration with NixOS/Home Manager

Add to your flake inputs:

```nix
{
  inputs = {
    # ... other inputs
    nvf-config.url = "github:viicslen/nvf-config";
  };
}
```

Then use in your configuration:

```nix
# In your home.nix or system configuration
environment.systemPackages = [
  inputs.nvf-config.packages.${system}.default
];
```

### Development Shell

For development work on this configuration:

```bash
nix develop
```

## File Structure

```
.
├── flake.nix          # Main flake definition
├── packages.nix       # Package definitions
├── apps.nix          # Application configurations
├── config/
│   ├── default.nix   # Main Neovim configuration
│   └── keybinds.nix  # Custom keybindings
└── pkgs/
    ├── laravel-nvim.nix    # Laravel plugin package
    └── neotest-pest.nix    # Pest testing plugin package
```

## Keybindings Reference

This configuration follows a **unified keymap philosophy** shared with the window managers (Hyprland/Niri) and Nixvim to maximize muscle memory and minimize cognitive overhead. See the **Unified Keymap Philosophy** section below for details.

### Leader Key
- `<leader>` = `Space`

### Core Keybinds

**File Operations**
| Keybind | Mode | Action |
|---------|------|--------|
| `Ctrl + S` | n, v, i | Save file |
| `<leader>;` | n | Append semicolon |
| `<leader>,` | n | Append comma |

**Buffer Management**
| Keybind | Mode | Action |
|---------|------|--------|
| `Tab` | n | Next buffer |
| `Shift + Tab` | n | Previous buffer |
| `<leader>q` | n | Close buffer |

**Visual Mode**
| Keybind | Mode | Action |
|---------|------|--------|
| `>` | v | Indent selection (stay in visual) |
| `<` | v | Unindent selection (stay in visual) |

**Comments**
| Keybind | Mode | Action |
|---------|------|--------|
| `Ctrl + /` | n, v | Toggle line/selection comment |
| `Ctrl + ?` | n, v | Toggle block comment |
| `<leader>/` | n | Toggle operator line |
| `<leader>?` | n | Toggle operator block |

**AI Assistance**
| Keybind | Mode | Action |
|---------|------|--------|
| `Alt + L` | i | Accept Copilot line |

### LSP Keybinds (Leader + G)

| Keybind | Mode | Action |
|---------|------|--------|
| `<leader>gD` | n | Go to declaration |
| `<leader>gd` | n | Go to definition |
| `<leader>gt` | n | Go to type definition |
| `<leader>h` | n | Hover documentation |
| `<leader>gi` | n | List implementations |
| `<leader>gr` | n | List references |

### Laravel Operations (Leader + LL)

| Keybind | Mode | Action |
|---------|------|--------|
| `<leader>lla` | n | Laravel Artisan |
| `<leader>llr` | n | Laravel Routes |
| `<leader>llm` | n | Laravel Related |
| `gf` | n | Smart goto file (resource-aware) |

### Git Worktrees (Leader + GW)

| Keybind | Mode | Action |
|---------|------|--------|
| `<leader>gws` | n | Worktrees picker |
| `<leader>gwc` | n | Create new worktree |
| `<leader>gwa` | n | Worktree for existing branch |

### Unified Keymap Philosophy

This configuration is part of a **cross-system keymap standardization** that spans both editors (Neovim/Nixvim) and window managers (Hyprland/Niri).

**Design Principles:**
1. **Leader-based namespacing**: Logical grouping of related actions (`<leader>g*` for git, `<leader>ll*` for Laravel, etc.)
2. **Plugin-specific mappings**: Comment, Copilot, and buffer navigation configured through plugin settings
3. **Consistent with Nixvim**: Same keybinds as the Nixvim config for seamless switching
4. **Mnemonic keys**: Q for quit, G for git, LL for Laravel, etc.
5. **Cross-system harmony**: Editor keybinds mirror window manager patterns

**Cross-System Consistency:**
- **Close/Quit**: `<leader>q` (buffer), `SUPER+Q` (window in WMs)
- **File Navigation**: Laravel's `gf` enhances resource discovery, matching WM file manager philosophy
- **Namespace Organization**: Same structure as Nixvim for muscle memory

**Namespace Organization:**
- `<leader>g*` - Git and LSP operations
- `<leader>gw*` - Git worktrees (sub-namespace)
- `<leader>ll*` - Laravel operations
- Plugin-specific: Configured via plugin mappings (comment-nvim, copilot, bufferline)

This structured approach reduces cognitive load and makes muscle memory transferable between your editor and window manager.

See the Hyprland, Niri, and Nixvim READMEs for their implementations of this unified system.

### Which-Key Integration

The configuration uses Which-Key with Helix preset for discoverable keybindings. Press `<leader>` and wait to see available options.

## Configuration Highlights

### Language Servers

- **PHP**: Intelephense for comprehensive PHP support
- **TypeScript**: Built-in TS server with error translation
- **Multi-language**: Automatic LSP setup for all supported languages

### Formatter Setup

- **PHP**: Laravel Pint for code formatting
- **Conform.nvim**: Extensible formatting system

### AI Integration

- **Copilot**: Integrated with completion system
- **Avante**: Advanced AI features with cursor planning and Claude tool mode

### Development Workflow

- **Auto-suggestions**: Disabled by default, available on-demand
- **Hard-time**: Vim improvement training with hint mode
- **Leap Motion**: Enhanced cursor movement
- **Multi-cursors**: Advanced editing capabilities

## Customization

The configuration is modular and can be easily customized by:

1. **Modifying `config/default.nix`**: Adjust plugin settings and enable/disable features
2. **Updating `config/keybinds.nix`**: Add or modify keybindings
3. **Adding packages in `pkgs/`**: Include additional Vim plugins
4. **Extending `packages.nix`**: Add new package variants or configurations

## Building and Testing

```bash
# Build the configuration
nix build

# Check formatting
nix build .#checks.x86_64-linux.nix-fmt

# Run the built Neovim
./result/bin/nvim
```

## Dependencies

This configuration uses:

- **nvf**: The core Neovim configuration framework
- **nixpkgs**: For base packages and Vim plugins
- **flake-parts**: For modular flake organization

## License

This configuration is provided as-is for personal use. Individual plugins and components maintain their respective licenses.

## Contributing

This is a personal configuration, but feel free to:

- Fork and adapt for your own use
- Submit issues if you find problems
- Suggest improvements via pull requests

---

Built with ❤️ using [nvf](https://github.com/notashelf/nvf) and the Nix ecosystem.
