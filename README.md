## My vim files

### Installation
```
git clone git@github.com:gnepud/dotvim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
mkdir ~/.config
ln -s ~/.vim ~/.config/nvim
```

### Neovim plugins

This configuration uses Neovim 0.12+ and lazy.nvim. `init.vim` sources
`vimrc` relative to `stdpath('config')`; the existing Vimscript settings and
mappings are retained.

Start `nvim` after creating the symlinks above. lazy.nvim and missing plugins
are installed automatically into `.lazy` under the Neovim config directory. Git and network access are
required for the first installation. `lazy-lock.json` records plugin revisions
and should be committed with the configuration.

- `:Lazy` opens the plugin manager.
- `:Lazy restore` restores the versions recorded in the lockfile.
- `:Lazy update` updates plugins and rewrites the lockfile.
- `:Lazy build fzf` rebuilds the FZF binary if needed.
- `:TSUpdate` updates installed Treesitter parsers.

All plugins load at startup except NERDTree, which loads on
`:NERDTreeToggle` (`,n`). Sonokai loads first. Plugin specifications are in
`lua/dotvim/plugins.lua`; Treesitter, LSP, context, and Git signs have separate
configuration files in the same directory.

Treesitter requires a C compiler, `tar`, `curl`, and `tree-sitter-cli` 0.26.1+.
Missing parsers install asynchronously. Reopen the file after the first install
finishes to enable highlighting.

### Configuration layout

- `init.vim` → `vimrc`: entry points and explicit loading order.
- `config/options.vim`: leader, display, editing, indentation, and clipboard options.
- `config/commands.vim`: custom commands and utility functions.
- `config/keymaps.vim`: editor mappings; plugin mappings live in their specs.
- `config/statusline.vim`: statusline layout and its helper functions.
- `config/autocmds.vim`: file-change checks and statusline cache invalidation.
- `lua/dotvim/lazy.lua`: plugin-manager bootstrap and settings.
- `lua/dotvim/plugins.lua`: plugin specs, dependencies, and lifecycle hooks.
- Other `lua/dotvim/*.lua` files: individual plugin configuration and key specs.
- `lazy-lock.json`: tracked plugin versions.

Options load before plugins so the leader and display settings are available
when plugins initialize. Commands load before mappings; statusline helpers load
before their cache-invalidation hooks. Both entry points use the current XDG
configuration directory rather than a fixed `~/.vim` path.
