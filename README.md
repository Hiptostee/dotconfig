# dotfiles

Personal config for Ghostty, Zellij, and Neovim. All three are themed with Catppuccin Mocha.

---

## Essential Vim Keybinds

### Lines
| Key | Action |
|---|---|
| `o` | New line below, enter insert |
| `O` | New line above, enter insert |
| `A` | Insert at end of line |
| `I` | Insert at start of line |
| `yy` | Copy line |
| `dd` | Delete line |
| `p` / `P` | Paste below / above cursor |
| `cc` | Delete line and enter insert |
| `J` | Join line below to current |

### Selecting & editing text
| Key | Action |
|---|---|
| `viw` / `diw` / `ciw` | Select / delete / change word under cursor |
| `vi"` / `ci"` | Select / change inside quotes |
| `vi(` / `ci(` | Select / change inside parens |
| `vi{` | Select inside braces (function body) |
| `va{` | Select around braces (includes the `{}`) |
| `V` + `j/k` | Select whole lines |
| `vap` | Select whole paragraph (blank-line-delimited block) |
| `ggVG` | Select entire file |

### Surround (nvim-surround)
| Key | Action |
|---|---|
| `ysiw"` | Wrap word in `"` |
| `ysiw)` | Wrap word in `()` |
| `cs"'` | Change `"` to `'` |
| `ds"` | Remove surrounding `"` |
| `S"` | Wrap visual selection in `"` |

### Navigation
| Key | Action |
|---|---|
| `{` / `}` | Jump to previous / next blank line |
| `%` | Jump to matching bracket |
| `*` | Search for word under cursor |
| `gg` / `G` | Top / bottom of file |
| `Ctrl o` / `Ctrl i` | Jump back / forward in jump list |
| `zz` | Center screen on cursor |

### Undo / redo
| Key | Action |
|---|---|
| `u` | Undo |
| `Ctrl r` | Redo |

---

## Ghostty

| Setting | Value |
|---|---|
| Theme | Catppuccin Mocha |
| Font | MesloLGS NF, size 14 |
| Cursor | Block |
| Background | Custom image at 10% opacity, 20px blur, 95% window opacity |
| Padding | 12px horizontal, 8px vertical |
| Title bar | Tabs style (macOS) |

---

## Zellij

- Theme: Catppuccin Mocha
- Default mode: normal (not locked)
- Startup tips disabled
- Full custom keybinds with vim-style navigation (`hjkl`) throughout all modes

### Key modes

| Trigger | Mode |
|---|---|
| `Ctrl p` | Pane |
| `Ctrl t` | Tab |
| `Ctrl n` | Resize |
| `Ctrl h` | Move |
| `Ctrl s` | Scroll |
| `Alt s` | Session |
| `Ctrl g` | Locked |

### Pane mode
| Key | Action |
|---|---|
| `h/j/k/l` | Move focus |
| `d` | New pane down |
| `r` | New pane right |
| `s` | New stacked pane |
| `f` | Toggle fullscreen |
| `w` | Toggle floating panes |
| `e` | Embed or float pane |
| `i` | Pin pane |
| `z` | Toggle pane frames |

### Tab mode
| Key | Action |
|---|---|
| `n` | New tab |
| `x` | Close tab |
| `1-9` | Go to tab |
| `[` / `]` | Break pane left / right |

---

## Neovim

Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim)

Leader key: `Space`

### LSP & Completion (`lua/plugins/lsp.lua`)

Servers managed via Mason, auto-installed on first launch:

| Language | Server | Formatter |
|---|---|---|
| C / C++ | clangd (with clang-tidy, background index) | clang-format |
| TypeScript / JavaScript | ts_ls + eslint | prettier |
| JSX / TSX | ts_ls + eslint | prettier |
| JSON / HTML / CSS | ts_ls / eslint | prettier |
| Ruby / Rails | ruby_lsp | rubocop |

Completion engine: nvim-cmp with LSP, buffer, and path sources. Snippets via LuaSnip.

#### LSP keymaps (active when LSP attaches)
| Key | Action |
|---|---|
| `gd` | Go to definition |
| `K` | Hover docs |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>vd` | Open diagnostic float |
| `<leader>vca` | Code actions |
| `<leader>vrn` | Smart rename |
| `<leader>vrr` | Find references |
| `<leader>vws` | Workspace symbol search |

---

### UI (`lua/plugins/ui.lua`)

| Plugin | What it does |
|---|---|
| catppuccin/nvim | Mocha colorscheme, transparent background |
| lualine | Statusline themed to catppuccin-mocha |
| which-key | Keybind popup on `Space` |
| indent-blankline | Indent guides |
| trouble.nvim | Diagnostics panel |
| nvim-treesitter | Syntax highlighting for C, C++, Lua, Python, Ruby, JS, TS, TSX, JSON, HTML, CSS, and more |
| alpha-nvim | Startup dashboard with custom NVIM ASCII header |
| rainbow-delimiters | Rainbow-colored brackets, parens, braces |
| mini.animate | Smooth cursor, scroll, and window animations |
| cellular-automaton | Easter egg animations on buffer text |
| drop.nvim | Falling stars animation on dashboard (screensaver after 5 min idle) |
| nvim-highlight-colors | Inline color swatches for hex, rgb, hsl, and Tailwind classes |
| noice.nvim + nvim-notify | Floating command palette, LSP progress spinners, styled notifications |

#### UI keymaps
| Key | Action |
|---|---|
| `<leader>xx` | Toggle all diagnostics (Trouble) |
| `<leader>xb` | Toggle buffer diagnostics (Trouble) |
| `<leader>fml` | Make it rain (cellular automaton) |
| `<leader>gol` | Game of life (cellular automaton) |

---

### Navigation (`lua/plugins/navigation.lua`)

| Plugin | What it does |
|---|---|
| telescope.nvim + fzf-native | Fuzzy finder with native C sorter |
| neo-tree.nvim | File explorer sidebar |

#### Navigation keymaps
| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Open buffers |
| `<leader>e` | Toggle file explorer |

---

### Workflow (`lua/plugins/workflow.lua`)

| Plugin | What it does |
|---|---|
| toggleterm.nvim | Terminal inside nvim (horizontal + vertical) |
| gitsigns.nvim | Inline git hunk indicators and staging |
| vim-fugitive | Git commands from inside nvim |
| diffview.nvim | Side-by-side git diff and file history |
| nvim-autopairs | Auto-close brackets, quotes, etc. |
| Comment.nvim | Line and block commenting |
| conform.nvim | Format on save for all supported filetypes |
| nvim-surround | Add, change, delete surrounding characters with `ys`/`cs`/`ds` motions |
| vim-rails | Rails-aware navigation (models, controllers, views, specs) |
| vim-test | Run RSpec (and other test frameworks) from inside nvim via toggleterm |
| harpoon2 | Fast file bookmarking and switching |

#### Surround motions
| Key | Action |
|---|---|
| `ysiw"` | Surround word with `"` |
| `ysiw)` | Surround word with `()` |
| `ys$"` | Surround to end of line with `"` |
| `cs"'` | Change surrounding `"` to `'` |
| `cs(]` | Change surrounding `()` to `[]` |
| `dst` | Delete surrounding HTML tag |
| `ds"` | Delete surrounding `"` |
| `S"` | Surround visual selection with `"` (visual mode) |

#### Terminal keymaps
| Key | Action |
|---|---|
| `Ctrl \` | Toggle horizontal terminal |
| `<leader>tv` | Toggle vertical terminal |
| `Ctrl h/j/k/l` | Navigate out of terminal to nvim windows |

#### Git keymaps
| Key | Action |
|---|---|
| `<leader>gs` | Git status (fugitive) |
| `<leader>gb` | Git blame |
| `<leader>gd` | Git diff split |
| `<leader>gv` | Open diffview |
| `<leader>gV` | Close diffview |
| `<leader>gh` | File git history |
| `]h` / `[h` | Next / previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hR` | Reset buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff this |

#### Test keymaps
| Key | Action |
|---|---|
| `<leader>tn` | Run nearest test |
| `<leader>tf` | Run current test file |
| `<leader>ta` | Run full test suite |
| `<leader>tl` | Re-run last test |

#### Harpoon keymaps
| Key | Action |
|---|---|
| `<leader>a` | Add file to harpoon |
| `Ctrl e` | Open harpoon menu |
| `<leader>1-4` | Jump to harpoon file 1-4 |

---

### Debug (`lua/plugins/debug.lua`)

DAP (Debug Adapter Protocol) configured for C and C++ via codelldb.

| Key | Action |
|---|---|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>dt` | Toggle DAP UI |

---

## First-time setup

1. Install [lazy.nvim](https://github.com/folke/lazy.nvim) (auto-bootstrapped on first `nvim` launch)
2. Open nvim and run `:Lazy sync`
3. Run `:Mason` and install `prettier`
4. Run `:TSUpdate` to install all treesitter parsers
5. Install the tree-sitter CLI (required to compile some parsers):
   ```
   npm install -g tree-sitter-cli
   ```
