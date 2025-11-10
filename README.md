# dotfiles

This is the configuration that I use to set up new machines, managed by `chezmoi` and `ansible`.
This setup is currently only valid for Fedora machines.

```sh
curl -fsSL https://raw.githubusercontent.com/calebrjc/dotfiles/trunk/dot_local/bin/pre-chezmoi.sh | sh

export PATH=$PATH:$BIN_DIR
export BW_SESSION=$(bw login --raw)
export GITHUB_USERNAME=calebrjc

BINDIR="$HOME/.local/bin" sh -c "$(curl -fsSL get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```
