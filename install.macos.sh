echo ""
sleep 0.5

###########################
# Symbolic Links

# Zsh
ln -s -f $HOME/Code/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -s -f $HOME/Code/dotfiles/zsh/.zprofile $HOME/.zprofile
ln -s -f $HOME/Code/dotfiles/zsh/.p10k.zsh $HOME/.p10k.zsh
ln -s -f $HOME/Code/dotfiles/zsh/.zprofile.macos.zsh $HOME/.zprofile.macos.zsh

# Neovim
ln -s -f $HOME/Code/dotfiles/nvim $HOME/.config/nvim

###########################
# Programs

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Zsh
brew install zsh
chsh -s "$(which zsh)"

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

# cmake
brew install cmake

# conan
brew install conan

# ripgrep
brew install ripgrep

###########################
# External Assets
cd $HOME/Library/Fonts
curl -o "MesloLGS NF Regular.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf'
curl -o "MesloLGS NF Bold.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf'
curl -o "MesloLGS NF Italic.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf'
curl -o "MesloLGS NF Bold Italic.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf'
cd $HOME/Code/dotfiles

echo "Done! No further action need, though you might want to reboot your terminal"
