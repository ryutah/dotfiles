#!/usr/bin/env bash

sudo apt-get install software-properties-common

# for github cli
type -p curl >/dev/null || sudo apt-get install curl -y
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
  sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

sudo apt-get update

# for pack
sudo add-apt-repository ppa:cncf-buildpacks/pack-cli

sudo apt-get update -y && sudo apt-get -y upgrade

sudo apt-get -y install \
  build-essential \
  curl \
  unzip \
  zsh \
  git \
  tmux \
  libedit-dev \
  libssl-dev \
  bzip2 \
  libbz2-dev \
  libsqlite3-dev \
  libreadline-dev \
  libwayland-egl-backend-dev \
  xclip \
  libffi-dev \
  cmake \
  pkg-config \
  libfreetype6-dev \
  libfontconfig1-dev \
  libxcb-xfixes0-dev \
  libxkbcommon-dev \
  direnv \
  gcc \
  gh \
  make \
  pkg-config \
  autoconf \
  automake \
  python3-docutils \
  libseccomp-dev \
  libjansson-dev \
  libyaml-dev \
  libxml2-dev \
  x11vnc \
  bison \
  trash-cli \
  libmysqlclient-dev \
  pgcli \
  graphviz \
  graphviz-dev \
  jq \
  apt-transport-https \
  g++ \
  postgresql-client \
  postgresql-client-common \
  libpq-dev \
  fonts-ipafont \
  pack-cli \
  cloc \
  libwebkit2gtk-4.1-dev

# for python
sudo apt-get -y install \
  python-tk

sudo apt -y install \
  podman

# for php
sudo apt-get -y install \
  libcurl4-openssl-dev \
  re2c \
  libgd-dev \
  libonig-dev \
  libpq-dev \
  libzip-dev
