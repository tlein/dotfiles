# teg
if [ -f ~/.tegrc ]; then
    . ~/.tegrc
fi

# teg
export TEG_HOME=$HOME/Code/teg
export DOTFILES_HOME=$HOME/Code/dotfiles

# neovim
export PATH=$PATH:$HOME/Code/neovim/bin
alias gvim="nvim"

# smarterslate
export CV_HOME=$HOME/Code/smarterslate

# conan
export PATH=$PATH:$HOME/.local/bin
