#!/usr/bin/env bash

version=$(curl --silent "https://api.github.com/repos/tsl0922/ttyd/releases/latest" | jq -r ".tag_name")
curl -L -o ${HOME}/.local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/${version}/ttyd.x86_64
chmod +x ${HOME}/.local/bin/ttyd
