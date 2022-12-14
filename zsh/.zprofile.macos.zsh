# teg
export TEG_HOME=$HOME/Code/teg
export PATH=$PATH:$HOME/Code/teg

# dotfiles
export DOTFILES_HOME=$HOME/Code/dotfiles

# neovim
export PATH=$PATH:$HOME/Code/neovim/bin
alias gvim="nvim"

# smarterslate
export CV_HOME=$HOME/Code/smarterslate
export CV_EXTLIBS_DIR=$HOME/.circavia/extlibs

eval "$(/opt/homebrew/bin/brew shellenv)"

export LD_LIBRARY_PATH="/Library/Developer/CommandLineTools/usr/lib/:$LD_LIBRARY_PATH"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export RAFT_PATH=$HOME/Code/ILikeDucks/Raft
export PATH=$PATH:$RAFT_PATH/release/bin
export NODE_PATH=$NODE_PATH:$RAFT_PATH/release/lib

export ANDROID_NDK=$HOME/Library/Android/sdk/ndk/24.0.8215888
export ANDROID_HOME=$HOME/Library/Android/sdk

export PATH=$PATH:$ANDROID_NDK
export PATH=$PATH:$ANDROID_HOME/platform-tools

# pip
export PATH=$PATH:$HOME/Library/Python/3.8/bin

# Setting PATH for Python 3.10
# The original version is saved in .zprofile.pysave
export PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"

export PATH=$PATH:/opt/premake5/bin
export TM_SDK_DIR=$HOME/Code/themachinery
export TM_LIB_DIR=$TM_SDK_DIR/lib
export PATH=$PATH:$TM_SDK_DIR/bin/Release

alias my_zsh_reload="source ~/.zshrc"

# MacPorts Installer addition on 2022-06-12_at_13:26:55: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# MacPorts Installer addition on 2022-06-12_at_13:26:55: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH="/opt/local/share/man:$MANPATH"
# Finished adapting your MANPATH environment variable for use with MacPorts.

export PATH=$PATH:/opt/lua-language-server/bin
export PATH=$PATH:$HOME/go/bin

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export FrameworkPathOverride=/Library/Frameworks/Mono.framework/Versions/Current/lib/mono/4.8-api

export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:/opt/zig
export PATH=$PATH:$HOME/zls

# Google's depot_tools for bootstrapping google projects (aka Dawn for me)
export PATH=$PATH:$HOME/Code/depot_tools

bindkey '\e.' insert-last-word

function d {
    TARGET="$HOME/.config/dirlinks/${1?}"
    if [ -f "$TARGET" ]; then
        cd `cat $TARGET`
    else
        echo "${TARGET?} quick link not found"
    fi
}

function e {
    TARGET="$HOME/.config/dirlinks/${1?}"
    if [ -f "$TARGET" ]; then
        cd `cat $TARGET`
        nvim .
    else
        echo "${TARGET?} quick link not found"
    fi
}
