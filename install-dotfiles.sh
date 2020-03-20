#!/bin/bash

target=`ls rc.d/`
cd ..
for x in $target; do
  ln -s .dotfiles/rc.d/$x ./.$x
done

# for .oh-my-zsh
cd .dotfiles
git submodule init
git submodule update
