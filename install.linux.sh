echo ""
sleep 0.5

###########################
# Symbolic Links

# Zsh
ln -s -f $HOME/Code/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -s -f $HOME/Code/dotfiles/zsh/.zprofile $HOME/.zprofile
ln -s -f $HOME/Code/dotfiles/zsh/.p10k.zsh $HOME/.p10k.zsh
ln -s -f $HOME/Code/dotfiles/zsh/.zprofile.linux.zsh $HOME/.zprofile.linux.zsh

# Neovim
mkdir -p $HOME/.config
ln -s -f $HOME/Code/dotfiles/nvim $HOME/.config/nvim

# oh-my-zsh
old_zsh=$ZSH
export ZSH=$HOME/.oh-my-zsh
rm -rf $HOME/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc --unattended
export ZSH=$old_zsh

# Powerlevel10k
# !!!INSTALL FONT!!!: https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k
# Font instructions for macOS terminal at above link!
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

# build neovim
git clone https://github.com/neovim/neovim $HOME/Code/neovim
cd $HOME/Code/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd $HOME/Code/dotfiles

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


###########################
# External Assets
mkdir -p $HOME/Code/dotfiles/external/fonts
cd $HOME/Code/dotfiles/external/fonts
curl -o "MesloLGS NF Regular.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf'
curl -o "MesloLGS NF Bold.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf'
curl -o "MesloLGS NF Italic.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf'
curl -o "MesloLGS NF Bold Italic.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf'
cd $HOME/Code/dotfiles

echo "Done! Don't forget to install the fonts located inside of \"dotfiles/external/fonts\"! Then it would be a good idea to reboot your terminal."
