#!/bin/bash

git submodule foreach git pull origin master
#current_dir=`pwd`
#for file in bundle/*; do
   #if [ -d $file ]; then
      #echo ''
      #echo $file;
      #cd $file
      #git pull
      #cd $current_dir
   #fi
#done
