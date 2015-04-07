#!/bin/sh

git clone https://github.com/fujibee/dotfiles.git .dotfiles

cd .dotfiles
sh ./install-apps.sh

#sudo -c "echo /opt/local/bin/bash >> /etc/shells"
chsh -s /usr/local/bin/zsh

sh ./install-dotfiles.sh
