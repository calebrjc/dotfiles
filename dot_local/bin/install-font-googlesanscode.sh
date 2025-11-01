#!/bin/bash

FONT_URL="https://github.com/E-Vertin/GoogleSansCode-NerdFont/releases/download/v6.001/GoogleSansCode-NFM-v6.001.tar.xz"
TMP_DIR="$(mktemp -d)"
ARCHIVE="$TMP_DIR/GoogleSansCode-NFM-v6.001.tar.xz"
FONT_DIR="$HOME/.local/share/fonts"
FONT_NAME_PATTERN="GogleSansCode"

if find "$FONT_DIR" -type f -iname "*${FONT_NAME_PATTERN}*.ttf" | grep -q .; then
    rm -rf "$TMP_DIR"
    exit 0
fi

mkdir -p "$FONT_DIR"
curl -L "$FONT_URL" -o "$ARCHIVE"
tar xf "$ARCHIVE" -C "$TMP_DIR"
find "$TMP_DIR" -type f \( -iname "*.ttf" -o -iname "*.otf" \) -exec cp -v {} "$FONT_DIR" \;
fc-cache -f "$FONT_DIR"
rm -rf "$TMP_DIR"