# The Awakener — Neovim Configuration

Opinionated, lightweight Neovim config that uses `lazy.nvim` for plugin management and ships with a small set of commonly used plugins (treesitter, lsp, completion, telescope, neo-tree, catppuccin theme, and lualine).

This README explains how to install, use, and customize the config.

## Quick install

1. Backup your existing Neovim config (if any):

   - Move or copy your current config folder (for example `~/.config/nvim`) somewhere safe.

2. Clone this repo (or copy the `nvim` folder) into your Neovim config location. Example (Windows WSL/git bash):

```
# from your desired parent dir, e.g. ~/.config
git clone <your-dotfiles-repo-url> theawakener-dotfiles
# then copy or symlink this nvim folder into Neovim config path
ln -s /path/to/theawakener-dotfiles/nvim ~/.config/nvim
```

On native Windows (not WSL), place the `nvim` folder under `%USERPROFILE%\AppData\Local\nvim` or use the environment variable `XDG_CONFIG_HOME`.

3. Start Neovim. The config bootstraps `lazy.nvim` automatically and will clone required plugins on first run.

4. After startup, run `:Lazy` to see plugin status, or restart Neovim to ensure all plugins finish installing.

## What this config contains

- Bootstrap: `init.lua` bootstraps `folke/lazy.nvim` and loads `lua/vim-opt.lua` and the `lua/plugins` folder.
- Options: `lua/vim-opt.lua` sets basic editor options and leader keys.
- Plugins (each in `lua/plugins/*.lua`):
  - catppuccin/nvim — colorscheme
  - nvim-treesitter — syntax highlighting and indentation
  - nvim-lspconfig + mason — LSP servers (lua_ls, ts_ls, clangd, pyright, gopls)
  - nvim-cmp + LuaSnip — completion and snippets
  - nvim-neo-tree/neo-tree.nvim — file explorer (Ctrl-b opens it)
  - nvim-telescope/telescope.nvim — fuzzy finder (leader+ff / leader+fg)
  - nvim-lualine/lualine.nvim — statusline

Files of interest:
- `init.lua` — entrypoint that bootstraps `lazy.nvim` and loads plugin specs.
- `lua/vim-opt.lua` — editor options and leader keys.
- `lua/plugins/` — each file returns a plugin spec consumed by `lazy.nvim`.

## Useful keymaps

- <Leader>ff — find files (Telescope)
- <Leader>fg — live grep (Telescope)
- <C-b> — toggle/reveal Neo-tree filesystem on the left
- K — LSP hover
- gd — go to definition
- <Leader>ca — code actions (normal & visual)

Note: `<Leader>` is set to space (` `). Local leader is `\\`.

## Customize

- Add plugins: create a new file under `lua/plugins/` that returns a plugin spec (compatible with `lazy.nvim`). See existing files for examples.
- Change options: edit `lua/vim-opt.lua` for editor settings (tabs, shiftwidth, leader, etc.).
- Change keymaps or plugin configs: edit the relevant file in `lua/plugins/` to change the `config = function()` block.

If you want to add personal mappings or settings without changing this repo, create a file `lua/user.lua` and `require('user')` from `init.lua` (or source it from your own config after loading this one).

## Troubleshooting

- Plugins not installed on startup: open Neovim and run `:Lazy sync` or `:Lazy install`.
- LSP servers missing: ensure you have `mason` installed (the config installs `mason` automatically). Open `:Mason` and install servers manually if needed.
- Colors not applied: ensure `catppuccin` is installed (should be automatic). You can change colorscheme in `lua/plugins/colors.lua`.

## Notes & assumptions

- This README covers the `nvim` folder in this repo; integrate it into your dotfiles as you prefer (symlink/copy).
- The config bootstraps `lazy.nvim` from the stable branch on first run.


