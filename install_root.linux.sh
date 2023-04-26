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

# neovim deps
apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
