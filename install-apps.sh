#!/bin/sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade
 
brew tap homebrew/versions
brew tap phinze/homebrew-cask
brew tap homebrew/binary
 
brew install brew-cask
 
# for dev
brew install zsh
brew install git
brew install wget
brew install curl
brew install vim
#brew install postgresql
#brew install mysql
#brew install node
#brew install ruby
brew cask install iterm2
brew cask install docker

# for desktop
brew cask install google-chrome
brew cask install dropbox
brew cask install evernote
#brew cask install microsoft-office
brew cask install google-japanese-ime
brew cask install google-drive-file-stream
brew cask install slack
brew cask install stack
brew cask install zoomus
brew cask install viscosity
brew cask install adobe-reader
#brew cask install messenger
#brew cask install spectacle

# from appstore
# xcode
# twitter
