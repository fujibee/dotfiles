#!/bin/sh

cd .dotfiles
sh ./install-apps.sh

chsh -s /usr/local/bin/zsh

sh ./install-dotfiles.sh

sh ./defaults-write.sh
