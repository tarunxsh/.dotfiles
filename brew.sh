#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"
# Install some other useful utilities like `sponge`.
brew install moreutils

# Install a modern version of Bash.
brew install bash
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
brew install openssh
brew install screen

## vcs
brew install gh
brew install git
brew install git-lfs
# brew install jj

brew install btop     # better top
brew install bat      # a cat(1) clone with syntax highlighting and Git integration
brew install fd       # simple, fast and user-friendly alternative to 'find'
brew install eza      # modern alternative to ls
brew install jq       # JSON processor
brew install yq       # YAML/JSON/XML/CSV/TOML processor

brew install --cask font-intel-one-mono
brew install font-hack-nerd-font    # required for eza

# awslabs
brew install awscli
brew install dynein

# Editors
# brew install helix
# brew install micro



brew install tmux
brew install aerospace
brew tap FelixKratz/formulae
brew install sketchybar

# Remove outdated versions from the cellar.
brew cleanup