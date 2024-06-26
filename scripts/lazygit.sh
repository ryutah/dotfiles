#!/usr/bin/env bash

cd $(dirname $0)/..
wd=$(pwd)

set -eux

ln -f -s ${wd}/lazygit/config.yaml ${HOME}/.config/lazygit/config.yml
