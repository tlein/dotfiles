# Dotfiles & Dev Machine Configuration

## Table of Contents

1. [Symbolic Links](#symbolic-links)
2. [Zsh & Oh-My-Zsh](#zsh-oh-my-zsh)
3. [Neovim](#neovim)

## Symbolic Links
Assumes `dotfiles` is placed under `~/Code`

```bash
# Zsh
ln -s ~/Code/dotfiles/zsh/.zshrc ~/.zshrc;
ln -s ~/Code/dotfiles/zsh/.zprofile ~/.zprofile;
ln -s ~/Code/dotfiles/zsh/.p10k.zsh ~/.p10k.zsh

# Neovim
ln -s  ~/Code/dotfiles/nvim ~/.config/nvim;
```

## Zsh & Oh-My-Zsh

### Overview
1. Install Zsh
2. Install oh-my-zsh
3. Install Powerlevel10k
    - https://github.com/romkatv/powerlevel10k
    - Install Fonts from README
    - Configure

### Install

#### macOS (`5.8.1`)
![macOS-Zsh-Terminal-Dark-Mode](/assets/images/dark_mode_terminal_zsh.png#gh-dark-mode-only)
![macOS-Zsh-Terminal-Light-Mode](/assets/images/light_mode_terminal_zsh.png#gh-light-mode-only)

```bash
# zsh
brew install zsh;

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";

# Powerlevel10k
# !!!INSTALL FONT!!!: https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k
# Font instructions for macOS terminal at above link!
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k;
```

## Neovim

### Install

#### macOS (`v0.8.0-dev+406-g502f03fc0`)


1. Install neovim
```bash
cd ~/Code;
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz;
tar xzf nvim-macos.tar.gz;
rm nvim-macos.tar.gz;
```

2. Install VimR (GUI)
    - https://github.com/qvacua/vimr/releases
    - Set font to "MesloLGS NF Regular 13.0"

