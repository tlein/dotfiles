#!/bin/bash

# Set a default value of install-specific variables for first time install
code_dir="${TJL_CODE_DIR:-$HOME/Code}"

case $(uname) in
    Darwin)
        echo "Installing for macOS..."
        echo ""
        source $code_dir/dotfiles/install.macos.sh
        ;;
    Linux)
        echo "Installing for Linux..."
        echo ""
        source $code_dir/dotfiles/install.linux.sh
        ;;
    *)
        echo "Unknown OS! Quitting install"
        exit 1
        ;;
esac
