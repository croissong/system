{
  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://tree-grepper.cachix.org"
    ];

    # cachix use tree-grepper -O /tmp/cachix-conf
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "tree-grepper.cachix.org-1:Tm/owXM+dl3GnT8gZg+GTI3AW+yX1XFVYXspZa7ejHg="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    # nixpkgs-pr.url = "github:r-ryantm/nixpkgs/auto-update/updatecli";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay/master";
      # no input overrides to use binary cache
    };

    tree-grepper = {
      url = "github:BrianHicks/tree-grepper";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    esplanade.url = "git+ssh://git@github.com/croissong/esplanade";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in rec {
    versions = builtins.fromJSON (builtins.readFile ./versions.json);
    packages = forAllSystems (pkgs: import ./pkgs {inherit pkgs versions;});

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays = import ./overlays {inherit inputs versions;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    vars = import /home/moi/dot/priv/vars.nix;

    nixosConfigurations = {
      bon = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./os/configuration.nix
          inputs.sops-nix.nixosModules.sops
        ];
      };

      bonVM = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules =
          nixosConfigurations
          + [
            ./os/vm.nix
          ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "moi@bon" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./hm/home.nix
          inputs.nix-index-database.hmModules.nix-index
        ];
      };
    };
  };
}
