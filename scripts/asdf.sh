#!/usr/bin/env zsh

cd $(dirname $0)/..
wd=$(pwd)

set -ux

if [[ ! -d ${HOME}/.asdf ]]; then
  git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf --branch v0.10.2
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

asdf install ghq latest
asdf install python latest
asdf install fzf latest
asdf install neovim latest
asdf install golang latest
asdf install nodejs latest
asdf install tmux latest
asdf install terraform latest
asdf install kind latest
asdf install java openjdk-19.0.1
asdf install deno latest
asdf install tflint 0.46.1

asdf global ghq $(asdf list ghq)
asdf global python $(asdf list python)
asdf global fzf $(asdf list fzf)
asdf global neovim $(asdf list neovim)
asdf global golang $(asdf list golang)
asdf global nodejs $(asdf list nodejs)
asdf global tmux $(asdf list tmux)
asdf global terraform $(asdf list terraform)
asdf global kind $(asdf list kind)
asdf global java openjdk-19.0.1
asdf global deno $(asdf list deno)
asdf global tflint 0.46.1
