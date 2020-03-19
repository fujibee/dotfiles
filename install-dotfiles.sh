#!/bin/bash

target=`ls -a .[a-z]*` # TODO need to avoid directories like `.git`
cd ..
for x in $target; do
  ln -s .dotfiles/$x ./$x
done

# for .oh-my-zsh
cd .dotfiles
git submodule init
git submodule update
