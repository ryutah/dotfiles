#!/usr/bin/env bash

cd $(dirname $0)/..
wd=$(pwd)

ln -f -s ${wd}/zshrc ${HOME}/.zshrc
