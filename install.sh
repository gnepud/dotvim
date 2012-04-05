#!/bin/bash

git submodule init
git submodule update
cd bundle/command-t/ruby/command-t
ruby extconf.rb
make
cd ~/.vim

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

current_dir=`pwd`
for file in bundle/*; do
   if [ -d $file ]; then
      echo ''
      echo $file;
      cd $file
      git checkout master
      cd $current_dir
   fi
done
