#!/bin/bash

if command -v ansible-playbook &> /dev/null; then
    echo "ansible is already installed, skipping..."
    exit 0
fi

sudo dnf install -y ansible ansible-collection-community-general
ansible-playbook ~/.setup/setup.yml --ask-become-pass