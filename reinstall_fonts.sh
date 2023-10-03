#!/bin/sh
trap "exit" INT

echo "Cloning & installing useful fonts"
mkdir -p ~/home/.fonts/
# NOTE this is pretty large (~5 GB at 2022-10)
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git ~/home/.fonts/
~/home/.fonts/install.sh Hack
rm -r ~/home/.fonts/
