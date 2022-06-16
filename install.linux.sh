echo ""
sleep 0.5

###########################
# Symbolic Links

# Zsh
ln -s -f $code_dir/dotfiles/zsh/.zshrc $user_home_dir/.zshrc
ln -s -f $code_dir/dotfiles/zsh/.zprofile $user_home_dir/.zprofile
ln -s -f $code_dir/dotfiles/zsh/.p10k.zsh $user_home_dir/.p10k.zsh
ln -s -f $code_dir/dotfiles/zsh/.zprofile.linux.zsh $user_home_dir/.zprofile.linux.zsh

# Neovim
ln -s -f $code_dir/dotfiles/nvim $user_home_dir/.config/nvim

###########################
# Programs

# Zsh
apt-get update
apt-get install zsh
chsh -s "$(which zsh)" $install_user

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
echo "NEED TO CONFIGURE INSTALLING CMAKE!!!!"

# conan
echo "NEED TO CONFIGURE INSTALLING CONAN!!!!"

# ripgrep
echo "NEED TO CONFIGURE INSTALLING RIPGREP!!!!"

###########################
# External Assets
cd $code_dir/external/fonts
curl -o "MesloLGS NF Regular.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf'
curl -o "MesloLGS NF Bold.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf'
curl -o "MesloLGS NF Italic.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf'
curl -o "MesloLGS NF Bold Italic.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf'
cd $code_dir/dotfiles

zsh
echo "Done! Don't forget to install the fonts located inside of \"dotfiles/external/fonts\"!"
