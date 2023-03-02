#!/usr/bin/env bash

set -eux

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile default --no-modify-path -y

source "${HOME}/.cargo/env"

cargo install exa fd-find bat ripgrep cargo-update
cargo install cross --git https://github.com/cross-rs/cross
