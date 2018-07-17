#!/bin/sh -exu

rustup component add rls-preview rust-analysis rust-src wasm32-unknown-unknown
cargo install clippy
