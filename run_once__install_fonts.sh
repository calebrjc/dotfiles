#!/bin/bash

FONTS=(
    "inter"
    "googlesanscode"
)

echo "Starting font installation..."

for font in "${FONTS[@]}"; do
    script="install-font-${font}.sh"
    if [[ -x "$script" ]]; then
        ./"$script"
    else
        echo "Warning: $script not found or not executable — skipping."
    fi
done