#!/bin/bash


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
    MINGW64*)
        echo "Installing for MinGW64..."
        echo ""
        source $code_dir/dotfiles/install.mingw64.sh
        ;;
    *)
        echo "Unknown OS! Quitting install"
        exit 1
        ;;
esac
