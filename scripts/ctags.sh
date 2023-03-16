#!/usr/bin/env bash

cd $HOME/.local/share

set -eux

if [[ -d ctags ]]; then
  rm -rf ctags
fi
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure --prefix=/usr/local
make
sudo make install
