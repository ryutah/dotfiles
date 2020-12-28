#!/bin/sh -exu

PROTO_BUF_VERSION=3.5.1

_install_protoc() {
  wget -O /tmp/protobuf.zip https://github.com/google/protobuf/releases/download/v${PROTO_BUF_VERSION}/protoc-${PROTO_BUF_VERSION}-osx-x86_64.zip
  unzip /tmp/protobuf.zip -d /tmp/protobuf
  mv /tmp/protobuf/bin/protoc $HOME/.local/bin
  rm -rf /tmp/protobuf /tmp/protobuf.zip
}

_install_protoc
