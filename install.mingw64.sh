echo ""
sleep 0.5

###########################
# Symbolic Links

# Zsh
rm $HOME/.zshrc
cmd /c 'mklink C:\msys64\home\tucker\.zshrc /h C:\Users\tucker\Code\dotfiles\zsh\.zshrc'
rm $HOME/.zprofile
cmd /c 'mklink C:\msys64\home\tucker\.zprofile /h C:\Users\tucker\Code\dotfiles\zsh\.zprofile'
rm $HOME/.p10k.zsh
cmd /c 'mklink C:\msys64\home\tucker\.p10k.zsh /h C:\Users\tucker\Code\dotfiles\zsh\.p10k.zsh'
rm $HOME/.zprofile.mingw64.zsh
cmd /c 'mklink C:\msys64\home\tucker\.zprofile.mingw64.zsh /h C:\Users\tucker\Code\dotfiles\zsh\.zprofile.mingw64.zsh'

# Neovim
rm /c/Users/tucker/AppData/Local/nvim
cmd /c 'mklink C:\Users\tucker\AppData\Local\nvim /d C:\Users\tucker\Code\dotfiles\nvim'

# Conan
cmd /c 'mklink C:\msys64\home\tucker\.conan /d C:\Users\tucker\.conan'

# JFrog Artifactory
cmd /c 'mklink C:\msys64\home\tucker\jfrog /d C:\Users\tucker\jfrog'

###########################
# Programs

pacman -Syu
pacman-key --refresh-keys

# Zsh
pacman -S zsh

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

# Neovim
pacman -S \
    mingw-w64-x86_64-{gcc,libtool,cmake,make,perl,python2,pkgconf,ninja,diffutils}

# Conan
pacman -S mingw-w64-x86_64-python-pip
pip3 install conan
echo "Need to install mingw64 conan profile to C:/Users/tucker/.conan/profiles/mingw64, see below comment for profile"
# [build_requires]
# [settings]
#     os=Windows
#     os_build=Windows
#     arch=x86_64
#     arch_build=x86_64
#     compiler=gcc
#     compiler.version=12
#     compiler.libcxx=libstdc++11
#     build_type=Debug
# [options]
# [env]

# ripgrep
pacman -S mingw-w64-x86_64-ripgrep

###########################
# External Assets
cd $HOME/Code/dotfiles/external/fonts
curl -o "MesloLGS NF Regular.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf'
curl -o "MesloLGS NF Bold.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf'
curl -o "MesloLGS NF Italic.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf'
curl -o "MesloLGS NF Bold Italic.ttf" -LO 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf'
cd $HOME/Code/dotfiles

zsh
echo "Done! Don't forget to install the fonts located inside of \"dotfiles/external/fonts\"!"
