# dotfiles

This is the configuration that I use to set up new machines, managed by `chezmoi` and `ansible`.
This setup is currently only valid for Fedora machines.

```sh
source <(curl -fsSL https://raw.githubusercontent.com/calebrjc/dotfiles/trunk/dot_local/bin/pre-chezmoi.sh)

export GITHUB_USERNAME=calebrjc
export BW_SESSION=$(bw login --raw)

BINDIR="$HOME/.local/bin" sh -c "$(curl -fsSL get.chezmoi.io)" -- init --apply git@github.com:$GITHUB_USERNAME/dotfiles.git
```
