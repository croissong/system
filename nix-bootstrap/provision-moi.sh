cd ~

# home-manager switch --flake path://$PWD/System/nix-config#moi@bon

mkdir -p ~/.config/chezmoi
export DOT=$HOME/Dot
chezmoi execute-template <~/Dot/dot_config/chezmoi/chezmoi.yaml.tmpl >~/.config/chezmoi/chezmoi.yaml
