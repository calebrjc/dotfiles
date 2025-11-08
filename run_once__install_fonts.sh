#!/bin/bash

python ~/.local/bin/fontmgr.py install \
    "https://github.com/E-Vertin/GoogleSansCode-NerdFont/releases/download/v6.001/GoogleSansCode-NFM-v6.001.tar.xz" \
    --pattern "*.ttf"
python ~/.local/bin/fontmgr.py install \
    "https://github.com/rsms/inter/releases/download/v4.1/Inter-4.1.zip" \
    --pattern "InterVariable*.ttf"
