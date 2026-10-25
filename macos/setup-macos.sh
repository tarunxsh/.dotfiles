#!/usr/bin/env bash

# Dock: minimize windows into app icon (default is next to the Trash)
defaults write com.apple.dock minimize-to-application -bool true
# Dock: zero delay auto-hide (only sets speed, doesn't enable auto-hide)
defaults write com.apple.dock autohide-delay # -float 0
defaults write com.apple.dock autohide-time-modifier # -float 0
# Dock: keep pinned apps visible after reboot
defaults write com.apple.dock static-only -bool false

# Finder: always column view (default is Icon View)
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
# Finder: search within current folder (default is entire Mac)
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Finder: show ~/Library
chflags nohidden ~/Library

# Hot corners: bottom-left = sleep display, bottom-right = show desktop
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

killall Dock
killall Finder

echo "macOS defaults applied!"