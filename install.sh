#!/bin/sh
echo "Creating pathogen directories"
mkdir -p ~/home/.vim/autoload ~/home/.vim/bundle && curl -LSso ~/home/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo "Cloning useful plugins"
git clone git://github.com/tpope/vim-repeat.git ~/home/.vim/bundle/vim-repeat
git clone git://github.com/tpope/vim-surround.git ~/home/.vim/bundle/vim-surround
git clone https://github.com/vim-airline/vim-airline ~/home/.vim/bundle/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes ~/home/.vim/bundle/vim-airline-themes
git clone https://github.com/nvie/vim-flake8 ~/home/.vim/bundle/vim-flake8
git clone git://github.com/tpope/vim-vinegar.git ~/home/.vim/bundle/vim-vinegar
git clone https://github.com/Valloric/YouCompleteMe.git ~/home/.vim/bundle/YouCompleteMe

echo "Cloning & installing useful fonts"
git clone https://github.com/powerline/fonts.git ~/home/.vim/fonts/
~/home/.vim/fonts/install.sh
echo "set guifont=Meslo\ LG\ L\ for\ Powerline:h11" >> ~/.gvimrc

echo "Symlink vim files"
ln -s ~/home/.vim ~/.vim
ln -s ~/home/.vimrc ~/.vimrc

echo "Symlink gitconfig"
# ln -s ~/home/.gitconfig ~/.gitconfig

echo "Symlink zsh files"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ln -s ~/home/.zshrc ~/.zshrc

echo "Installing brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install cask
brew install vim
brew link --overwrite vim
brew install python3
brew install transmission-cli &&  brew services start transmission-cli
brew install syncthing && brew services start syncthing
brew install watch
brew install ffmpeg
# brew install imagemagick
brew install coreutils
brew install cmake
brew install fswatch
brew install virtualenv
brew install direnv
brew install rename
brew install exiftool

brew install --cask opera
brew install --cask firefox
brew install --cask vlc
brew install --cask macvim
brew install --cask steam
brew install --cask docker
# brew install --cask android-file-transfer

git -C ~/home/.vim/bundle/YouCompleteMe submodule update --init --recursive
python3 ~/home/.vim/bundle/YouCompleteMe/install.py --all
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
