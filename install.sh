#!/bin/bash

git submodule init
git submodule update
cd bundle/command-t/ruby/command-t
ruby extconf.rb
make
cd ../../

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
