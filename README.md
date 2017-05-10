## My vim files

### Installation
```
git pull git@github.com:gnepud/dotvim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
ln -s ~/.vim ~/.config/nvim
```

Add init.vim for Neovim and setting up python
```
source ~/.vim/vimrc

# https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
let g:python_host_prog = '/path/to/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/path/to/.pyenv/versions/neovim3/bin/python'
```

NEOVIM > 0.2.0 default cursor
cf: (https://github.com/neovim/neovim/wiki/Following-HEAD#20170402)[https://github.com/neovim/neovim/wiki/Following-HEAD#20170402]
cf: (https://github.com/neovim/neovim/wiki/FAQ#how-can-i-change-the-cursor-shape-in-the-terminal)[https://github.com/neovim/neovim/wiki/FAQ#how-can-i-change-the-cursor-shape-in-the-terminal]

Install vim-plug
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Run `:PlugInstall` to install plugins.
