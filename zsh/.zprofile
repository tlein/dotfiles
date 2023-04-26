case `uname` in
    Darwin)
        source $HOME/.zprofile.macos.zsh
        ;;
    Linux)
        source $HOME/.zprofile.linux.zsh
        ;;
    MINGW64*)
        source $HOME/.zprofile.mingw64.zsh
        ;;
esac
