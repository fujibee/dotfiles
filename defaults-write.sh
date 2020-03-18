#!/bin/sh

defaults write com.apple.dock autohide -int 1
defaults write com.apple.dock orientation -string right
killall Dock

#defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
#defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
