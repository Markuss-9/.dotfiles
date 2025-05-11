#!/bin/bash

set -e  # Exit on error

# Check for Git installation
if ! command -v git &>/dev/null; then
    echo "Installing Git..."
    sudo apt update && sudo apt install -y git
fi

# Check for Zsh installation
if ! command -v zsh &>/dev/null; then
    echo "Installing Zsh..."
    sudo apt install -y zsh
fi

# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

# Link config files to home directory
DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup"
FILES=(.zshrc .gitconfig)

echo "Linking dotfiles..."
mkdir -p "$BACKUP_DIR"

for file in "${FILES[@]}"; do
    src="$DOTFILES_DIR/$file"
    dest="$HOME/$file"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Backing up $dest to $BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/"
    fi

    echo "Linking $src -> $dest"
    ln -s "$src" "$dest"
done

# Link .config files
echo "Linking .config files..."
mkdir -p "$HOME/.config"

echo "Linking nvim config files"
ln -s "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"

echo "Changing default shell to Zsh..."
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
fi

echo "Installation complete! Restart your terminal or run 'zsh'."
