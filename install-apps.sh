#!/bin/sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew update
brew upgrade
 
brew tap homebrew/versions
brew tap phinze/homebrew-cask
brew tap homebrew/binary
 
#brew install brew-cask
 
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

brew install --cask iterm2
brew install --cask docker
brew install --cask zerotier-one
#brew install --cask ngrok
brew install docker-compose
brew install hub
brew install git-flow
brew install --cask react-native-debugger
brew install --cask android-file-transfer
brew install --cask macdown
brew install --cask notion

# for desktop
brew install --cask google-chrome
brew install --cask dropbox
brew install --cask evernote
#brew install --cask microsoft-office
brew install --cask google-japanese-ime
brew install --cask google-drive
brew install --cask slack
brew install --cask zoomus
#brew install --cask viscosity
brew install --cask adobe-creative-cloud
brew install --cask authy
brew install --cask messenger
#brew install --cask spectacle
brew install --cask discord
brew install --cask kindle
brew install --cask abyssoft-teleport
brew install --cask stack-stack
brew install --cask deepl
brew install --cask microsoft-remote-desktop

# pass for Chrome
brew tap amar1729/formulae
brew install browserpass

brew tap homebrew/cask-fonts #You only need to do this once for cask-fonts
brew install --cask font-fantasque-sans-mono

# printer driver

brew tap homebrew/cask-drivers
brew install --cask apple-hewlett-packard-printer-drivers

# from App Store
# Xcode
# Twitter

# stack - https://getstack.app/
