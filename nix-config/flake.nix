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

    sandbox = "relaxed"; # esplanade (rust-skia)
  };

  inputs = {
    # hydra-check blender
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    nixpkgs-azure-cli.url = "github:nixos/nixpkgs/65d98cb037009203ae0e73972b9d0f3e1f23353e";

    # nixpkgs-updatecli.url = "github:r-ryantm/nixpkgs/auto-update/updatecli";

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

    priv.url = "git+file:///home/moi/dot/priv";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      systems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    rec {
      versions = builtins.fromJSON (builtins.readFile ./versions.json);
      packages = forAllSystems (system: import ./pkgs { inherit system inputs versions; });

      overlays = import ./overlays { inherit inputs versions; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      vars = inputs.priv.vars;

      nixosConfigurations = {
        bon = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./os/configuration.nix
            inputs.sops-nix.nixosModules.sops
            inputs.lix-module.nixosModules.default
          ];
        };

        bonVM = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = nixosConfigurations + [ ./os/vm.nix ];
        };
      };

      homeConfigurations = {
        "moi@bon" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./hm/home.nix
            inputs.nix-index-database.hmModules.nix-index
          ];
        };
      };
    };
}
