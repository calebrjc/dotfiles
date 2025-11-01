#!/bin/bash

FONT_URL="https://github.com/rsms/inter/releases/download/v4.1/Inter-4.1.zip"
TMP_DIR="$(mktemp -d)"
ARCHIVE="$TMP_DIR/Inter-4.1.zip"
FONT_DIR="$HOME/.local/share/fonts"
FONT_NAME_PATTERN="Inter"

if find "$FONT_DIR" -type f -iname "*${FONT_NAME_PATTERN}*.ttf" | grep -q .; then
    rm -rf "$TMP_DIR"
    exit 0
fi

mkdir -p "$FONT_DIR"
curl -L "$FONT_URL" -o "$ARCHIVE"
unzip -q "$ARCHIVE" -d "$TMP_DIR"
find "$TMP_DIR" -type f \( -iname "*Variable*.ttf" \) -exec cp -v {} "$FONT_DIR" \;
fc-cache -f "$FONT_DIR"
rm -rf "$TMP_DIR"