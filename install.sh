#!/bin/bash
case $(uname) in
    Darwin)
        echo "Installing for macOS..."
        echo ""
        source $HOME/Code/dotfiles/install.macos.sh
        ;;
    Linux)
        echo "Installing for Linux..."
        echo ""
        source $HOME/Code/dotfiles/install.linux.sh
        ;;
    MINGW64*)
        echo "Installing for MinGW64..."
        echo ""
        source $HOME/Code/dotfiles/install.mingw64.sh
        ;;
    *)
        echo "Unknown OS! Quitting install"
        exit 1
        ;;
esac
