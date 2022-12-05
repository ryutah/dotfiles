#!/usr/bin/env bash

cd $(dirname $0)/..
wd=$(pwd)

version=410.0.0-linux-x86_64

set -eux

mkdir -p .tmp/gcloud && cd .tmp/gcloud

curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${version}.tar.gz

tar -xf google-cloud-cli-${version}.tar.gz -C ${HOME}/.local

${HOME}/.local/google-cloud-sdk/install.sh \
  --quiet \
  --usage-reporting false \
  --command-completion false \
  --path-update false

rm -rf .tmp/gcloud

cd ${wd}
