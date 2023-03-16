#!/usr/bin/env bash

cd $HOME/.local/share

set -eux

if [[ -d win32yank ]]; then
  rm -rf win32yank
fi
git clone https://github.com/equalsraf/win32yank.git
cd win32yank
cross build --target x86_64-pc-windows-gnu --release

sudo mv ./target/x86_64-pc-windows-gnu/release/win32yank.exe /usr/local/bin/
