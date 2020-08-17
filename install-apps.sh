#!/bin/sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

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
brew install rbenv ruby-build
brew install yarn
brew install pass

brew cask install iterm2
brew cask install docker
brew cask install ngrok
brew install docker-compose
brew install hub
brew install git-flow
brew cask install react-native-debugger
brew cask install macdown
brew cask install notion

# for desktop
brew cask install google-chrome
brew cask install dropbox
brew cask install evernote
#brew cask install microsoft-office
brew cask install google-japanese-ime
brew cask install google-drive-file-stream
brew cask install slack
brew cask install zoomus
brew cask install viscosity
brew cask install adobe-acrobat-reader
brew cask install adobe-creative-cloud
brew cask install authy
#brew cask install messenger
#brew cask install spectacle
brew cask install android-file-transfer
brew cask install discord
brew cask install kindle

# pass for Chrome
brew tap amar1729/formulae
brew install browserpass

brew tap homebrew/cask-fonts #You only need to do this once for cask-fonts
brew cask install font-fantasque-sans-mono

# printer driver

brew tap homebrew/cask-drivers
brew cask install apple-hewlett-packard-printer-drivers

# from App Store
# Xcode
# Twitter

# stack - https://getstack.app/
