# Dotfiles & Dev Machine Configuration

## Table of Contents

1. [Install](#install)
2. [Zsh & Oh-My-Zsh](#zsh-oh-my-zsh)
3. [Neovim](#neovim)

## Install <a name="install"></a>

Run the following script, it will autodetect your OS.

```bash
./install.sh
```

Current supported OSes:

- macOS
- Linux

### macOS Callouts

Everything _should_ be ready from a fresh start, the script will elevate to root
when needed.

### Linux Callouts

The necessary fonts will install to a `.gitignore`'d directory at the root of
this repository's directory: `dotfiles/external/fonts`. Since various Linux
distros have different methods of installing fonts, these fonts are required to
be manually installed after the `./install.sh` script is finished running.

## Zsh & Oh-My-Zsh <a name="zsh-oh-my-zsh"></a>

### macOS (`5.8.1`)

#### Preview (light & dark mode supported)

![macOS-Zsh-Terminal-Dark-Mode](/assets/images/dark_mode_terminal_zsh.png#gh-dark-mode-only)
![macOS-Zsh-Terminal-Light-Mode](/assets/images/light_mode_terminal_zsh.png#gh-light-mode-only)

## Neovim <a name="neovim"></a>

### macOS (`v0.8.0-dev+406-g502f03fc0`)

#### Install

1. Install VimR (GUI)
   - https://github.com/qvacua/vimr/releases
   - Set font to "MesloLGS NF Regular 13.0"

#### Preview (light & dark mode supported)

![macOS-Zsh-Terminal-Dark-Mode](/assets/images/dark_mode_terminal_zsh.png#gh-dark-mode-only)
![macOS-Zsh-Terminal-Light-Mode](/assets/images/light_mode_terminal_zsh.png#gh-light-mode-only)
