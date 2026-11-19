#!/usr/bin/env bash

# Run from the repository root. Package contents map directly into $HOME.
stow -t "$HOME" git zsh
stow -t "$HOME/.config/Code/User" vscode