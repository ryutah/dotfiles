#!/usr/bin/env bash

cd $(dirname $0)/..
wd=$(pwd)

set -eux

ln -s ${wd}/tmux.conf ${HOME}.tmux.conf
