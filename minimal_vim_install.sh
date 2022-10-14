#!/bin/sh
trap "exit" INT

echo "=== vim customizations ==="
if [ ! -d ~/home/vim/.vim/autoload ]; then
  echo "Creating pathogen directories"
  mkdir -p ~/home/vim/.vim/autoload ~/home/vim/.vim/bundle && curl -LSso ~/home/vim/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
else
  echo "\talready installed" "Pathogen"
fi

declare -a vim_plugins_src=(
  https://github.com/tpope/vim-repeat.git
  https://github.com/tpope/vim-surround.git
  https://github.com/vim-airline/vim-airline
  https://github.com/vim-airline/vim-airline-themes
  https://github.com/tpope/vim-vinegar.git
  # https://github.com/ycm-core/YouCompleteMe.git
  # https://github.com/godlygeek/tabular.git
  # https://github.com/psf/black.git
)
declare -a vim_plugins_dst=(
  ~/home/vim/.vim/bundle/vim-repeat
  ~/home/vim/.vim/bundle/vim-surround
  ~/home/vim/.vim/bundle/vim-airline
  ~/home/vim/.vim/bundle/vim-airline-themes
  ~/home/vim/.vim/bundle/vim-vinegar
  # ~/home/vim/.vim/bundle/YouCompleteMe
  # ~/home/vim/.vim/bundle/tabular
  # ~/home/vim/.vim/bundle/black
)
for (( i = 0; i < ${#vim_plugins_src[@]}; i ++ )); do
  if [ ! -d ${vim_plugins_dst[$i]} ]; then
    git clone ${vim_plugins_src[$i]} ${vim_plugins_dst[$i]}

    # if [ -d ~/home/vim/.vim/bundle/YouCompleteMe ]; then
    #   git -C ~/home/vim/.vim/bundle/YouCompleteMe submodule update --init --recursive
    #   python3 ~/home/vim/.vim/bundle/YouCompleteMe/install.py
    # fi
  else
    echo "\talready installed" ${vim_plugins_dst[$i]}
  fi
done

if [ ! -L ~/.vim ]; then
  echo "Symlink vim files"
  ln -s ~/home/vim/.vim ~/.vim
else
  echo "\talready symlinked vim"
fi
if [ ! -L ~/.vimrc ]; then
  echo "Symlink vimrc files"
  ln -s ~/home/vim/.vimrc ~/.vimrc
else
  echo "\talready symlinked vimrc"
fi

echo "=== vim compute helptags ==="
vim -c Helptags -c 'qa!'

# brew install --cask macvim

# vi: ft=zsh
