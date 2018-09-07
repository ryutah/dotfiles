#!/bin/sh -exu

rustup component add rls-preview rust-analysis rust-src --toolchain nightly
rustup component add rustfmt-preview
