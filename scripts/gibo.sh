#!/usr/bin/env bash

set -eux

mkdir -p ${HOME}/.local/bin

curl -L https://raw.github.com/simonwhitaker/gibo/master/gibo \
  -so ${HOME}/.local/bin/gibo && chmod +x ${HOME}/.local/bin/gibo && gibo update
