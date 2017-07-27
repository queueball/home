#!/bin/sh
echo "Creating pathogen directories"
mkdir -p ~/home/.vim/autoload ~/home/.vim/bundle && curl -LSso ~/home/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo "Cloning useful plugins"
git clone https://github.com/kien/ctrlp.vim.git ~/home/.vim/bundle/ctrlp.vim
git clone --recursive https://github.com/davidhalter/jedi-vim.git ~/home/.vim/bundle/jedi-vim
git clone git://github.com/tpope/vim-repeat.git ~/home/.vim/bundle/vim-repeat
git clone git://github.com/tpope/vim-surround.git ~/home/.vim/bundle/vim-surround
git clone https://github.com/vim-airline/vim-airline ~/home/.vim/bundle/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes ~/home/.vim/bundle/vim-airline-themes
git clone https://github.com/nvie/vim-flake8 ~/home/.vim/bundle/vim-flake8
git clone git://github.com/tpope/vim-vinegar.git ~/home/.vim/bundle/vim-vinegar

echo "Cloning & installing useful fonts"
git clone https://github.com/powerline/fonts.git ~/home/.vim/fonts/
~/home/.vim/fonts/install.sh
echo "set guifont=Meslo\ LG\ L\ for\ Powerline:h11" >> ~/.gvimrc

echo "Symlink vim files"
ln -s ~/home/.vim ~/.vim
ln -s ~/home/.vimrc ~/.vimrc