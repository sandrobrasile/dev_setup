#!/bin/bash
# exit on error
set -e

GNU_GLOBAL_VERSION=6.5.7

# install minimal tools to survive
# install python stuff (needed by emacs conf)
# install c++ stuff (needed by emacs conf)
sudo apt-get update
sudo apt-get install git cmake ipython python-virtualenv pylint clang-4.0 llvm-4.0 libclang-4.0-dev clang-format-4.0
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-4.0 100 \
--slave /usr/bin/clang++ clang++ /usr/bin/clang++-4.0 \
--slave /usr/bin/clang-check clang-check /usr/bin/clang-check-4.0 \
--slave /usr/bin/clang-query clang-query /usr/bin/clang-query-4.0 \
--slave /usr/bin/clang-rename clang-rename /usr/bin/clang-rename-4.0 \
--slave /usr/bin/clang-format clang-format /usr/bin/clang-format-4.0

# install emacs25
# add PPA
sudo add-apt-repository ppa:kelleyk/emacs
# update APT and install (stable) emacs25
sudo apt-get update
sudo apt-get install emacs25

# Set emacs as the default editor in git
read -p "Do you want to set emacs as the default git editor? (y, n)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Setting emacs as default git editor"
    git config --global core.editor "emacs"
fi

install Gnu Global
read -p "Do you want to install Gnu Global? (y, n) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
   echo 'Installing Gnu Global...'
   wget http://tamacom.com/global/global-$GNU_GLOBAL_VERSION.tar.gz
   tar xzvf global-$GNU_GLOBAL_VERSION.tar.gz
   rm global-$GNU_GLOBAL_VERSION.tar.gz
   cd global-$GNU_GLOBAL_VERSION
   sudo ./configure --disable-gtagscscope
   sudo make
   sudo make install
   cd .. && sudo rm -R --force global-$GNU_GLOBAL_VERSION
   echo 'Gnu Global installed'
fi

# install/build rtags (rdm rtag daemon)
# read -p "Do you want to install rtags daemon? (y, n)" -n 1 -r
# echo    # (optional) move to a new line
# if [[ $REPLY =~ ^[Yy]$ ]]
# then
#     echo 'Installing rtags...'
#     sudo mkdir ~/opensource && cd !$
#     sudo git clone --recursive https://github.com/Andersbakken/rtags.git
#     cd rtags
#     sudo mkdir build
#     cd build
#     sudo cmake .. && sudo make && sudo make install
#     echo 'rtags installed'
# fi
