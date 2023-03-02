#!/usr/bin/env bash

cd $(dirname $0)

wd=$(pwd)

set -eux

./apt.sh
./zsh.sh
zsh ./asdf.sh
./rust.sh
./tmux.sh
./zinit.sh
./git.sh
./nvim.sh
zsh ./npm.sh
./editorconfig.sh
./gcloud.sh
./gibo.sh

if [[ $(uname -a | grep 'microsoft') != "" ]]; then
  ./wsl.sh
  ./win32yank.sh
fi
