# Neovim configuration

Use Neovim 0.12 or later.

## Install

On macOS, install [Homebrew](https://brew.sh/) first.
Then install the tools:

```sh
brew install neovim git fzf ripgrep tree-sitter-cli
```

Treesitter also needs a C compiler. If you do not have one, install Apple's tools:

```sh
xcode-select --install
```

Use Git to download the configuration:

```sh
mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}"
git clone git@github.com:gnepud/dotvim.git "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
```

If you already use `~/.vim`, keep your `~/.config/nvim` symlink.

Start `nvim`. lazy.nvim installs the plugins in `.lazy`.
The first installation needs an internet connection.
Wait for the plugin and parser installations to finish. Then restart Neovim.

Run `:checkhealth` to check the installation.
Install the language servers listed in `lua/dotvim/lsp.lua` for the languages you use.

## Plugins

| Command | Action |
| --- | --- |
| `:Lazy` | Open the plugin manager. |
| `:Lazy restore` | Restore the versions in `lazy-lock.json`. |
| `:Lazy update` | Update plugins and `lazy-lock.json`. |
| `:Lazy build fzf` | Install or update the FZF binary. |
| `:TSUpdate` | Update installed Treesitter parsers. |

Keep `lazy-lock.json` in Git to share the same plugin versions across devices.

Press `,n` to open NERDTree. Other plugins load at startup.

Treesitter needs a C compiler, `tar`, `curl`, and `tree-sitter-cli` 0.26.1+.
It installs missing parsers in the background.
After the first installation, reopen your file to enable syntax highlighting.

## Files

| File | Content |
| --- | --- |
| `init.vim` | Configuration entry point. |
| `config/options.vim` | Editor options. |
| `config/keymaps.vim` | Editor shortcuts. |
| `config/commands.vim` | Custom commands. |
| `config/statusline.vim` | Statusline settings and functions. |
| `config/autocmds.vim` | File checks and statusline updates. |
| `lua/dotvim/lazy.lua` | Plugin manager settings. |
| `lua/dotvim/plugins.lua` | Plugin declarations and shortcuts. |
| Other `lua/dotvim/*.lua` files | Settings for individual plugins. |
