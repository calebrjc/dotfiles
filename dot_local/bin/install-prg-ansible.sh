#!/bin/bash

if command -v ansible-playbook &> /dev/null; then
    echo "ansible is already installed, skipping..."
end

sudo dnf install ansible ansible-collection-community-general