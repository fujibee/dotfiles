#!/bin/bash

target=`ls -a .[a-z]*`
cd ..
for x in $target; do
  ln -s .dotfiles/$x ./$x
done
