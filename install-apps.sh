#!/bin/sh

brew update
brew upgrade
 
brew tap homebrew/versions
brew tap phinze/homebrew-cask
brew tap homebrew/binary
 
brew install brew-cask
brew install zsh
brew install git
brew install wget
brew install curl
brew install vim
brew install postgresql
brew install mysql
brew install node
brew install ruby
 
# for dev
brew cask install virtualbox  
brew cask install vagrant
brew cask install vagrant-manager

# for desktop
brew cask install google-chrome
brew cask install dropbox
brew cask install evernote
brew cask install microsoft-office
brew cask install google-japanese-ime
brew cask install google-drive
brew cask install skype
brew cask install slack
brew cask install viscosity
brew cask install adobe-reader
brew cask install messenger
brew cask install spectacle

# for appstore
# xcode
# twitter
