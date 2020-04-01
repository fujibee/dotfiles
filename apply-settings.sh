#!/bin/sh

# plist files
cp -p plists/* ~/Library/Preferences/

# dock
defaults write com.apple.dock autohide -int 1
defaults write com.apple.dock orientation -string right
killall Dock

# key repeat
defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)

# Tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Magic Mouse
defaults write -g com.apple.mouse.scaling -float 5.0 # track speed
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string TwoButton
defaults write com.apple.AppleMultitouchMouse MouseButtonMode -string TwoButton

# menu bar
defaults write com.apple.systemuiserver menuExtras -array \
"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
"/System/Library/CoreServices/Menu Extras/Clock.menu" \
"/System/Library/CoreServices/Menu Extras/Displays.menu" \
"/System/Library/CoreServices/Menu Extras/Volume.menu" \
"/System/Library/CoreServices/Menu Extras/TextInput.menu" \
"/System/Library/CoreServices/Menu Extras/Battery.menu"
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
killall SystemUIServer

# Restart
sudo shutdown -r now

# key modifires
# changing modifier key by CLI is hard. Do it mannualy for now. See: https://apple.stackexchange.com/questions/13598/updating-modifier-key-mappings-through-defaults-command-tool

# Google Japanese Input AZIK
# General > Keymap > Romaji table > Customize > Edit > import from file.. and load settings/google_japanese_ime_azik.txt

