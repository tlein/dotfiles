echo ""
sleep 0.5

###########################
# Symbolic Links

# Zsh
ln -s -f $user_home_dir/Code/dotfiles/zsh/.zshrc $user_home_dir/.zshrc
ln -s -f $user_home_dir/Code/dotfiles/zsh/.zprofile $user_home_dir/.zprofile
ln -s -f $user_home_dir/Code/dotfiles/zsh/.p10k.zsh $user_home_dir/.p10k.zsh
ln -s -f $user_home_dir/Code/dotfiles/zsh/.zprofile.linux.zsh $user_home_dir/.zprofile.linux.zsh

# Neovim
mkdir -p $user_home_dir/.config
ln -s -f $user_home_dir/Code/dotfiles/nvim $user_home_dir/.config/nvim

###########################
# Programs
apt-get update
apt-get install python3-pip

# Zsh
apt-get install zsh
usermod -s /usr/bin/zsh tucker

# oh-my-zsh
old_zsh=$ZSH
export ZSH=$user_home_dir/.oh-my-zsh
rm -rf $user_home_dir/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc --unattended
export ZSH=$old_zsh

# Powerlevel10k
# !!!INSTALL FONT!!!: https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k
# Font instructions for macOS terminal at above link!
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $user_home_dir/.oh-my-zsh/custom/themes/powerlevel10k

# cmake
apt-get install cmake

# conan
pip3 install conan

# ripgrep
apt-get install ripgrep

# neovim
apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
git clone https://github.com/neovim/neovim $user_home_dir/Code/neovim
cd $user_home_dir/Code/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
make install
cd $user_home_dir/Code/dotfiles

###########################
# External Assets
mkdir -p $user_home_dir/Code/dotfiles/external/fonts
cd $user_home_dir/Code/dotfiles/external/fonts
curl -o "MesloLGS NF Regular.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf'
curl -o "MesloLGS NF Bold.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf'
curl -o "MesloLGS NF Italic.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf'
curl -o "MesloLGS NF Bold Italic.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf'
cd $user_home_dir/Code/dotfiles

echo "Done! Don't forget to install the fonts located inside of \"dotfiles/external/fonts\"! Then it would be a good idea to reboot your terminal."
