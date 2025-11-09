#!/bin/bash

set -euo pipefail

BIN_DIR=~/.local/bin

mkdir -p $BIN_DIR
export PATH=$PATH:$BIN_DIR

# Install Bitwarden
(
    TMP_DIR=$(mktemp -d)
    trap 'rm -rf "$TMP_DIR"' EXIT
    cd "$TMP_DIR"

    curl -fsSL "https://vault.bitwarden.com/download/?app=cli&platform=linux" -o bw.zip
    unzip -o bw.zip > /dev/null
    mv bw $BIN_DIR

    echo "Installed Bitwarden CLI to $BIN_DIR"
)

sudo dnf update -y > /dev/null

# Install Ansible
(
    if command -v ansible-playbook &> /dev/null; then
        echo "ansible is already installed, skipping..."
        exit 0
    fi

    sudo dnf install -y ansible ansible-collection-community-general > /dev/null

    echo "Installed Ansible"
)
