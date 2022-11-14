# teg
if [ -f ~/.tegrc ]; then
    . ~/.tegrc
fi

# neovim
alias gvim="nvim"

# smarterslate
export CV_HOME=$HOME/Code/smarterslate
export CV_EXTLIBS_DIR=$HOME/.circavia/extlibs

# conan
export PATH=$PATH:$HOME/.local/bin

# the machinery
export TM_SDK_DIR=$HOME/Code/themachinery
export TM_LIB_DIR=$TM_SDK_DIR/lib
export PATH=$PATH:$TM_SDK_DIR/bin/Release

# jfrog conan artifactory
export JFROG_HOME=$HOME/jfrog

# go
export GOROOT=/mingw64/lib/go
export GOPATH=/mingw64
