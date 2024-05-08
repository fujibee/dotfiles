#!/bin/sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

eval "$(/opt/homebrew/bin/brew shellenv)"

brew update
brew upgrade
 
#brew tap homebrew/versions
#brew tap phinze/homebrew-cask
#brew tap homebrew/binary
#brew tap homebrew/core
#brew tap homebrew/cask
brew tap homebrew/cask-versions
 
#brew install brew-cask
 
# for dev
brew install zsh
brew install git
brew install wget
brew install curl
brew install vim
brew install pass
brew install tmux
brew install gh
brew install xcodesorg/made/xcodes

brew install --cask iterm2
brew install --cask zerotier-one
brew install --cask figma
brew install --cask docker

#brew tap aws/tap
#brew install awscli
#brew install aws-sam-cli

#brew install postgresql
#brew install rbenv ruby-build
#brew install yarn
#brew install docker-compose
#brew install hub
#brew install git-flow
#brew install mysql
#brew install nvm
#brew install ruby
#brew install planetscale/tap/pscale

#brew install --cask unity-hub
#brew install --cask visual-studio
#brew install --cask react-native-debugger
#brew install --cask android-file-transfer
#brew install --cask macdown
#brew install --cask ngrok

#brew tap ethereum/ethereum
#brew install ethereum
#brew install solidity

# for desktop
brew install --cask google-chrome
brew install --cask dropbox
brew install --cask evernote
brew install --cask slack
brew install --cask zoom
brew install --cask notion
brew install --cask authy
brew install --cask messenger
brew install --cask telegram
brew install --cask discord
brew install --cask kindle
brew install --cask deepl
brew install --cask tunnelbear
brew install --cask asana
brew install --cask adobe-creative-cloud
brew install --cask microsoft-office
brew install --cask microsoft-remote-desktop
brew install --cask visual-studio-code
sudo softwareupdate --install-rosetta && brew install --cask google-japanese-ime

#brew install --cask google-drive
#brew install --cask stack-stack
#brew install --cask vlc
#brew install --cask sidequest
#brew install --cask viscosity
#brew install --cask spectacle
#brew install --cask abyssoft-teleport

# pass for Chrome
#brew tap amar1729/formulae
#brew install browserpass

brew tap homebrew/cask-fonts #You only need to do this once for cask-fonts
brew install --cask font-fantasque-sans-mono

# printer driver

#brew tap homebrew/cask-drivers
#brew install --cask apple-hewlett-packard-printer-drivers

# from App Store
# Twitter
# upnote
