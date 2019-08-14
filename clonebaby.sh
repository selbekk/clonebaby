#!/bin/sh

# Huge thanks to Matthew Mueller and his blogpost at http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew.."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew
brew update

echo "Installing packages.."

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4 (Hello Shellshock)
brew install bash

# Install other useful binaries
binaries=(
  python
  tree
  ack
  git
  hub
  node
  maven
  tldr
)

# Install the binaries
brew install ${binaries[@]}

# Install Cask
brew tap caskroom/cask

# Remove outdated versions from the cellar
brew cleanup

apps=(
  dropbox
  google-chrome
  firefox
  spotify
  java
  visual-studio-code
  transmission
  slack
  qlcolorcode
  quicklook-json
  intellij-idea
  iterm2
)

# Adding beta versions
brew tap caskroom/versions

echo "Installing apps.."
brew cask install ${apps[@]}

echo "Setting up zsh"
curl -L http://install.ohmyz.sh | sh
echo export PATH='/usr/local/bin:$(brew --prefix coreutils)/libexec/gnubin:$PATH' >> ~/.zshrc # <- TODO: Make idempotent

echo "Settings.."
defaults write com.apple.systemsound 'com.apple.sound.uiaudio.enabled' -int 0
defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -bool false
defaults write com.apple.finder AppleShowAllFiles YES

defaults write -g InitialKeyRepeat -int 20
defaults write -g KeyRepeat -int 1

defaults write NSGlobalDomain com.apple.mouse.scaling -float 2

defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock autohide -bool true
killall Dock

exit 0
