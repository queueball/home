#!/bin/sh
trap "exit" INT

# open https://iterm2.com/downloads.html
# general -> preferences -> Load Preferences from a custom folder or url
#   use '~/home/iterm_configs'

################################################################################
echo "=== font setup ==="
if [ ! -d ~/home/.fonts/ ]; then
  echo "Cloning & installing useful fonts"
  mkdir -p ~/home/.fonts/
  # NOTE this is pretty large (~5 GB at 2022-10)
  git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git ~/home/.fonts/
  ~/home/.fonts/install.sh Hack
  rm -r ~/home/.fonts/
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

if [ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
  echo "\t Cloning packer"
  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
else
  echo "\talready downloaded packer"
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
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ln -s ~/home/zsh_configs/.zshrc ~/.zshrc
  else
    echo "\talready symlinked .zshrc"
  fi

  if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  else
    echo "\talready installed" "zsh-autosuggestions"
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
    android-file-transfer
    docker
    firefox
    iina
    raspberry-pi-imager
    rectangle
    roku-remote-tool
    signal
    steam
    turbo-boost-switcher
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
