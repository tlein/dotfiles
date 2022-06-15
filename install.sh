#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Must run as root"
  exit
fi

install_user=""
print_usage() {
    echo "Tucker Lein's Environment Install Script- 0.1 (2022-06-14)"
    echo ""
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

user_home_dir=$(eval echo "~$install_user")

# Set a default value of install-specific variables for first time install
code_dir="${TJL_CODE_DIR:-$user_home_dir/Code}"

case `uname` in
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
