#!/usr/bin/env zsh

cd $(dirname $0)/..
wd=$(pwd)

set -ux

if [[ ! -d ${HOME}/.asdf ]]; then
  git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf --branch v0.18.0
  make
  mv ./asdf ${HOME}/.local/bin/
fi

export PATH=${HOME}/.asdf/bin:${PATH}

ln -f -s ${wd}/asdf/default-npm-packages ${HOME}/.default-npm-packages
ln -f -s ${wd}/asdf/default-python-packages ${HOME}/.default-python-packages

asdf plugin add ghq
asdf plugin add python
asdf plugin add fzf
asdf plugin add neovim
asdf plugin add golang
asdf plugin add nodejs
asdf plugin add tmux
asdf plugin add terraform
asdf plugin add java
asdf plugin add deno
asdf plugin-add kind https://github.com/reegnz/asdf-kind.git
asdf plugin-add tflint https://github.com/skyzyx/asdf-tflint
asdf plugin add lazydocker https://github.com/comdotlinux/asdf-lazydocker.git
asdf plugin add lazygit https://github.com/nklmilojevic/asdf-lazygit.git
asdf plugin-add poetry https://github.com/asdf-community/asdf-poetry.git
asdf plugin add lua

asdf install ghq latest
asdf install python latest
asdf install fzf latest
asdf install neovim latest
asdf install golang latest
asdf install nodejs latest
asdf install tmux latest
asdf install terraform latest
asdf install kind latest
asdf install java openjdk-25
asdf install deno latest
asdf install tflint latest
asdf install lazydocker latest
asdf install lazygit latest
asdf install poetry latest
asdf install lua latest

asdf set -u ghq latest
asdf set -u python latest
asdf set -u fzf latest
asdf set -u neovim latest
asdf set -u golang latest
asdf set -u nodejs latest
asdf set -u tmux latest
asdf set -u terraform latest
asdf set -u kind latest
asdf set -u java openjdk-25
asdf set -u deno latest
asdf set -u tflint latest
asdf set -u lazydocker latest
asdf set -u lazygit latest
asdf set -u poetry latest
asdf set -u lua latest
