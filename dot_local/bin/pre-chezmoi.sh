#!/bin/bash

mkdir -p ~/.local/bin

# Install BitWarden
curl -L "https://vault.bitwarden.com/download/?app=cli&platform=linux" -o bw.zip \
    && unzip -o bw.zip \
    && mkdir -p ~/.local/bin \
    && sudo mv bw ~/.local/bin \
    && rm bw.zip

export PATH=$PATH:~/.local/bin