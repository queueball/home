#!/bin/sh
echo "=== vim customizations ==="
if [ ! -d ~/home/.vim/autoload ]; then
  echo "Creating pathogen directories"
  mkdir -p ~/home/.vim/autoload ~/home/.vim/bundle && curl -LSso ~/home/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
else
  echo "\talready installed" "Pathogen"
fi

declare -a vim_plugins_src=(
  https://github.com/tpope/vim-repeat.git
  https://github.com/tpope/vim-surround.git
  https://github.com/vim-airline/vim-airline
  https://github.com/vim-airline/vim-airline-themes
  https://github.com/tpope/vim-vinegar.git
  https://github.com/ycm-core/YouCompleteMe.git
  https://github.com/tpope/vim-fugitive.git
)
declare -a vim_plugins_dst=(
  ~/home/.vim/bundle/vim-repeat
  ~/home/.vim/bundle/vim-surround
  ~/home/.vim/bundle/vim-airline
  ~/home/.vim/bundle/vim-airline-themes
  ~/home/.vim/bundle/vim-vinegar
  ~/home/.vim/bundle/YouCompleteMe
  ~/home/.vim/bundle/vim-fugitive
)
for (( i = 0; i < ${#vim_plugins_src[@]}; i ++ )); do
  if [ ! -d ${vim_plugins_dst[$i]} ]; then
    git clone ${vim_plugins_src[$i]} ${vim_plugins_dst[$i]}

    if [ -d ~/home/.vim/bundle/YouCompleteMe ]; then
      git -C ~/home/.vim/bundle/YouCompleteMe submodule update --init --recursive
      python3 ~/home/.vim/bundle/YouCompleteMe/install.py
    fi
  else
    echo "\talready installed" ${vim_plugins_dst[$i]}
  fi
done

if [ ! -d ~/home/.vim/fonts/ ]; then
  echo "Cloning & installing useful fonts"
  git clone https://github.com/powerline/fonts.git ~/home/.vim/fonts/
  ~/home/.vim/fonts/install.sh
  echo "set guifont=Meslo\ LG\ L\ for\ Powerline:h11" >> ~/.gvimrc
else
  echo "\talready installed fonts"
fi

if [ ! -L ~/.vim ]; then
  echo "Symlink vim files"
  ln -s ~/home/.vim ~/.vim
else
  echo "\talready symlinked vim"
fi
if [ ! -L ~/.vimrc ]; then
  echo "Symlink vimrc files"
  ln -s ~/home/.vimrc ~/.vimrc
else
  echo "\talready symlinked vimrc"
fi

echo "=== git customizations ==="
if [ ! -L ~/.gitconfig ]; then
  echo "Symlink gitconfig"
  # ln -s ~/home/.gitconfig ~/.gitconfig
else
  echo "\talready symlinked .gitconfig"
fi

if [ -n $ZSH_VERSION ]; then
  echo "=== ZSH customizations ==="
  if [ ! -L ~/.zshrc ]; then
    echo "Symlink zsh files"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ln -s ~/home/.zshrc ~/.zshrc
  else
    echo "\talready symlinked .zshrc"
  fi

  if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  else
    echo "\talready installed" "zsh-autosuggestions"
  fi
fi

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
    cask
    vim
    the_silver_searcher
    python3
    transmission-cli
    syncthing
    watch
    ffmpeg
    # imagemagick
    coreutils
    cmake
    fswatch
    # virtualenv
    direnv
    rename
    exiftool
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
    # opera
    firefox
    # vlc
    macvim
    steam
    docker
    iina
    # android-file-transfer
  )
  for (( i = 0; i < ${#cask_libs[@]}; i ++ )); do
    if ! brew ls --cask --versions ${cask_libs[$i]} > /dev/null; then
      brew install --cask ${cask_libs[$i]}
    else
      echo "\talready installed" ${cask_libs[$i]}
    fi
  done
fi
