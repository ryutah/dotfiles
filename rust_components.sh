#!/bin/sh -exu

rustup component add rls-preview rust-analysis rust-src --toolchain stable
rustup component add rustfmt-preview
