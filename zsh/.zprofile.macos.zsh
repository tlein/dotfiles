if [ "$(uname)" == "Darwin" ]; then
    source $HOME/.zprofile.macos.bash
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    source $HOME/.zprofile.linux.bash
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something under 32 bits Windows NT platform
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    # Do something under 64 bits Windows NT platform
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

export LD_LIBRARY_PATH="/Library/Developer/CommandLineTools/usr/lib/:$LD_LIBRARY_PATH"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export RAFT_PATH=$HOME/Code/ILikeDucks/Raft
export PATH=$PATH:$RAFT_PATH/release/bin
export NODE_PATH=$NODE_PATH:$RAFT_PATH/release/lib

export ANDROID_NDK=$HOME/Library/Android/sdk/ndk/23.1.7779620
export ANDROID_HOME=$HOME/Library/Android/sdk

export PATH=$PATH:$ANDROID_NDK
export PATH=$PATH:$ANDROID_HOME/platform-tools

# pip
export PATH=$PATH:$HOME/Library/Python/3.8/bin

if [ -f ~/.tegrc ]; then
    . ~/.tegrc
fi

# Setting PATH for Python 3.10
# The original version is saved in .zprofile.pysave
export PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"

export PATH=$PATH:/opt/premake5/bin
export TM_SDK_DIR=$HOME/Code/themachinery
export TM_LIB_DIR=$TM_SDK_DIR/lib
export PATH=$PATH:$TM_SDK_DIR/bin/Release

export PATH=$PATH:$HOME/Code/neovim/bin

alias vimr="vimr -s"
alias my_zsh_reload="source ~/.zshrc"

# MacPorts Installer addition on 2022-06-12_at_13:26:55: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# MacPorts Installer addition on 2022-06-12_at_13:26:55: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH="/opt/local/share/man:$MANPATH"
# Finished adapting your MANPATH environment variable for use with MacPorts.

export CV_HOME=$HOME/Code/smarterslate
export PATH=$PATH:/opt/lua-language-server/bin
