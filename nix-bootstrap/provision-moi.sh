#!/usr/bin/env bash
set -euxo pipefail

export DOT=$HOME/dot/dotfiles
home-manager switch --show-trace --impure --flake path://$HOME/dot/system/nix-config#moi@bon

mkdir -p ~/.config/chezmoi
chezmoi execute-template <$DOT/dot_config/chezmoi/chezmoi.yaml.tmpl >~/.config/chezmoi/chezmoi.yaml

gpg --import ~/private.pgp
rm ~/private.pgp

# chezmoi apply
