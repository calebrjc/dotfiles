# dotfiles

This is the configuration that I use to set up new machines, managed by `chezmoi` and `ansible`.
This setup is currently only valid for Fedora machines.

```sh
curl -fsSL https://raw.githubusercontent.com/calebrjc/dotfiles/trunk/dot_local/bin/pre-chezmoi.sh | bash

export GITHUB_USERNAME=calebrjc
export BW_SESSION=$(bw login --raw)

sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```
