#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

# Pull latest changes from the dotfiles repository
if [[ -z "${SETUP_RESTARTED:-}" ]]; then
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    PULL_OUTPUT=$(git pull --rebase 2>&1 || true)
    if echo "$PULL_OUTPUT" | grep -q "Updating"; then
      echo "Updated dotfiles, restarting setup..."
      SETUP_RESTARTED=1 exec "$0" "$@"
    fi
  fi
fi

# Check for Xcode Command Line Tools, install if missing
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "Please re-run this script after Xcode CLI installation completes."
  exit 1
fi

# Check for Homebrew, install if missing
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Dynamically load shell environment (Apple Silicon & Intel support)
if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

echo "Installing brewfile packages..."
brew update
brew doctor || true
brew bundle --file="${DOTFILES_DIR}/Brewfile"
brew cleanup --prune=all

echo "Linking dotfiles with stow..."
STOW_PACKAGES=(zsh git mise mycli pgcli)
stow -v -R "${STOW_PACKAGES[@]}"

echo "Installing runtimes with mise..."
# requires mise to be installed via Brewfile
mise install

# echo "Linking Tailscale CLI..."
# sudo ln -sf /Applications/Tailscale.app/Contents/MacOS/Tailscale /usr/local/bin/tailscale

# Apply macOS defaults...
if [[ -f "./macos/setup-macos.sh" ]]; then
  echo "Applying macOS defaults..."
  bash "./macos/setup-macos.sh"
fi

echo "Setup completed successfully!"