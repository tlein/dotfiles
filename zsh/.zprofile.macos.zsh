# OS-level environment variables
export EDITOR='nvim'
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
# export PAGER='less -R' # Dunno what this is yet, sounds like a cool this to customize though
## LD_LIBRARY_PATH - Don't remember why I set LD_LIBARY_PATH honestly...
export LD_LIBRARY_PATH="/Library/Developer/CommandLineTools/usr/lib/:$LD_LIBRARY_PATH"
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)

# App specific environment variables
## dotfiles
export DOTFILES_HOME=$HOME/Code/dotfiles
## teg
export TEG_HOME=$HOME/Code/teg
## Squatbot
export SQUATBOT_HOME=$HOME/Code/ILikeDucks/squatbot
## Dropbox
export DROPBOX_HOME=$HOME/Library/CloudStorage/Dropbox
## Android
export ANDROID_NDK=$HOME/Library/Android/AndroidNDK.app/Contents/NDK
export ANDROID_HOME=$HOME/Library/Android/sdk
## zettelkasten notebook location
export ZK_NOTEBOOK_DIR=$DROPBOX_HOME/zettelkasten_tjl
## CMake
export CMAKE_OSX_SYSROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX13.1.sdk
export IOS_TOOLCHAIN_DIR=/Users/tucker/Code/ios-toolchain # iOS cmake toolchain since it doesn't come with it by default

# PATH additions
## Default nix config
if [[ -f '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]]; then
    source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    export NIX_PATH="$HOME/.nix-defexpr"
fi
## apps folder
export PATH=$PATH:$HOME/Apps
## Android, use it quite a bit for building Squatbot
export PATH=$ANDROID_NDK:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
## zls, don't like that this is global, *I don't use it much*, but my editor lsp does
export PATH=$PATH:$HOME/zls
## Python 3.10, don't like that this is global, *I don't use it much*
export PATH=/Library/Frameworks/Python.framework/Versions/3.10/bin:$PATH
## lua-language-server, don't like that this is global, *I don't use it much*, but my editor lsp does
export PATH=$PATH:/opt/lua-language-server/bin
## go, don't like that this is global, *I don't use it much*
export PATH=$PATH:$HOME/go/bin

# Homebrew, look into getting rid of if possible
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$(/opt/homebrew/bin/brew --prefix llvm@15)/bin:$PATH"
export LDFLAGS="$LDFLAGS -L$(/opt/homebrew/bin/brew --prefix llvm@15)/lib"
export CPPFLAGS="$CPPFLAGS -I$(/opt/homebrew/bin/brew --prefix llvm@15)/include"

# NVM, look into getting rid of if possible
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

source "$HOME/.cargo/env"
