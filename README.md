# dotfiles

This is the configuration that I use to set up new machines, managed by `chezmoi` and `ansible`.
This setup is currently only valid for Fedora machines.

```sh
export GITHUB_USERNAME=calebrjc
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```
