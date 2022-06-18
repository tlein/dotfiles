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

        install_user=""
        print_usage() {
            echo "Note: Must be run as root!"
            echo "Usage: ./install.sh -u os_username"
            echo ""
            echo "Arguments:"
            echo "   -u                   OS username to install this for"
        }

        while getopts 'u:' flag; do
            case "${flag}" in
                u) install_user="${OPTARG}" ;;
            esac
        done

        if [ -z "$install_user" ]; then
            print_usage
            echo ""
            echo "ERROR: No user provided"
            exit 1
        fi

        if [ "$EUID" -ne 0 ]; then
            echo "Must run as root"
            exit
        fi

        user_home_dir=$(eval echo "~$install_user")
        source $user_home_dir/Code/dotfiles/install.linux.sh

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
