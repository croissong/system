#!/usr/bin/env bash
set -euxo pipefail

gpg --import ~/private.pgp
rm ~/private.pgp

export DOT=$HOME/dot/dotfiles
home-manager switch --show-trace --impure --flake path://$HOME/dot/system/nix-config#moi@bon

mkdir -p ~/.config/chezmoi
chezmoi execute-template <$DOT/dot_config/chezmoi/chezmoi.yaml.tmpl >~/.config/chezmoi/chezmoi.yaml

chezmoi apply

ssh-keyscan -t rsa github.com >>~/.ssh/known_hosts
grm repos sync config --config ~/.config/git-repo-manager/config.yaml
# TODO: emacs tangle (+ rm ~/emacs.d)
