#!/bin/sh
trap "exit" INT

# open https://ghostty.org/download
#
################################################################################
echo "=== font setup ==="
if [ ! -d ~/home/.fonts/ ]; then
  ./reinstall_fonts.sh
else
  echo "\talready installed fonts"
fi

################################################################################
echo "=== nvim customizations ==="
if [ ! -d ~/.config/nvim ]; then
  echo "Symlink nvim init.lua"
  mkdir -p ~/.config
  ln -s -f ~/home/nvim ~/.config/nvim
else
  echo "\talready symlinked nvim"
fi

################################################################################
echo "=== git customizations ==="
if [ ! -L ~/.gitconfig ]; then
  echo "Symlink gitconfig"
  ln -s ~/home/git_configs/.gitconfig ~/.gitconfig
else
  echo "\talready symlinked .gitconfig"
fi

################################################################################
if [ -n $ZSH_VERSION ]; then
  echo "=== ZSH customizations ==="
  if [ ! -L ~/.zshrc ]; then
    echo "Symlink zsh files"
    ln -s ~/home/zsh_configs/.zshrc ~/.zshrc
  else
    echo "\talready symlinked .zshrc"
  fi

  if [ ! -L ~/.zsh_plugins.txt ]; then
    echo "Symlink zsh files"
    ln -s ~/home/zsh_configs/.zsh_plugins.txt ~/.zsh_plugins.txt
    ln -s ~/home/zsh_configs/.p10k.zsh ~/.p10k.zsh
  else
    echo "\talready symlinked .zshrc"
  fi
fi

################################################################################
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "=== MacOS customizations ==="
  if ! command -v brew &> /dev/null; then
    echo "Installing brew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    echo "\talready installed brew"
  fi

  echo "=== Brew customizations ==="
  declare -a brew_libs=(
    # brew leaves -r
    cask
    cmake
    exiftool
    ffmpeg
    git
    neovim
    node
    python3
    syncthing
    the_silver_searcher
    transmission-cli
    vim
    watch
    wget
    yt-dlp
    # bambu-studio
    # blender
    orcaslicer
    ncdu
    fzf
    fd
    antidote
  )
  for (( i = 0; i < ${#brew_libs[@]}; i ++ )); do
    if ! brew ls --versions ${brew_libs[$i]} > /dev/null; then
      brew install ${brew_libs[$i]}
      if [ ${brew_libs[$i]} = "vim" ]; then
        brew link --overwrite vim
      fi
      if [ ${brew_libs[$i]} = "transmission-cli" ]; then
        brew services start transmission-cli
      fi
      if [ ${brew_libs[$i]} = "syncthing" ]; then
        brew services start syncthing
      fi
    else
      echo "\talready installed" ${brew_libs[$i]}
    fi
  done

  echo "=== Cask customizations ==="
  declare -a cask_libs=(
    # brew list --cask
    # docker
    firefox
    iina
    # raspberry-pi-imager
    rectangle
    # steam
    zoom
    plex
  )
  for (( i = 0; i < ${#cask_libs[@]}; i ++ )); do
    if ! brew ls --cask --versions ${cask_libs[$i]} > /dev/null; then
      brew install --cask ${cask_libs[$i]}
    else
      echo "\talready installed" ${cask_libs[$i]}
    fi
  done
fi

# vi: ft=zsh
