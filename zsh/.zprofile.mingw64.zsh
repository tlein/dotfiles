# teg
if [ -f ~/.tegrc ]; then
    . ~/.tegrc
fi

# neovim
export PATH=$PATH:$HOME/Code/neovim/bin
alias gvim="nvim"

# smarterslate
export CV_HOME=$HOME/Code/smarterslate

# conan
export PATH=$PATH:$HOME/.local/bin

# the machinery
export TM_SDK_DIR=$HOME/Code/themachinery
export TM_LIB_DIR=$TM_SDK_DIR/lib
export PATH=$PATH:$TM_SDK_DIR/bin/Release
