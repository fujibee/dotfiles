#!/bin/bash

target=`ls rc.d/`
cd ..
for x in $target; do
  link=./.$x
  if [ -L $link ]; then
    unlink $link
  fi
  ln -s .dotfiles/rc.d/$x $link
done

# for .oh-my-zsh
cd .dotfiles
git submodule init
git submodule update
