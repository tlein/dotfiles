echo ""
sleep 0.5

###########################
# Programs
apt-get update

# Python
apt-get install python3-pip
apt-get install python3-venv

# Zsh
apt-get install zsh
usermod -s /usr/bin/zsh tucker

# cmake
apt-get install cmake

# ripgrep
apt-get install ripgrep

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# neovim deps
apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
