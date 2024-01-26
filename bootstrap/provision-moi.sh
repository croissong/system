#!/usr/bin/env bash
set -euxo pipefail

export DOT=$HOME/dot/dotfiles
home-manager switch --show-trace --impure --flake path://$HOME/dot/system/nix-config#moi@bon

gpg --pinentry-mode loopback --import ~/private.pgp
rm ~/private.pgp

# TODO: re-source env vars

mkdir -p ~/.config/chezmoi
chezmoi execute-template <$DOT/dot_config/chezmoi/chezmoi.yaml.tmpl >~/.config/chezmoi/chezmoi.yaml

export SOPS_AGE_KEY_FILE=~/.config/age/identity.age
chezmoi apply

ssh-keyscan -t rsa github.com >>~/.ssh/known_hosts
grm repos sync config --config ~/.config/git-repo-manager/config.yaml
# TODO: emacs tangle (+ rm ~/emacs.d)
