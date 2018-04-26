#!/bin/sh -exu

rustup component add rls-preview rust-analysis rust-src
cargo install clippy
