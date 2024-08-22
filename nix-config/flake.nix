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

    # nixpkgs-updatecli.url = "github:r-ryantm/nixpkgs/auto-update/updatecli";
    nixpkgs-inlyne.url = "github:nixos/nixpkgs/825fc0ae4b3a11c938c0506c56c60b09810a53f9";
    nixpkgs-nyxt.url = "github:nixos/nixpkgs/dc14ed91";

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

    gitwatch = {
      url = "github:gitwatch/gitwatch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

    treefmtEval = forAllSystems (pkgs: inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
  in rec {
    versions = builtins.fromJSON (builtins.readFile ./versions.json);
    packages =
      forAllSystems (system: import ./pkgs {inherit system inputs versions;});

    ### treefmt-nix
    formatter = forAllSystems (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
    checks = forAllSystems (pkgs: {
      formatting = treefmtEval.${pkgs.system}.config.build.check self;
    });
    ### treefmt-nix end

    overlays = import ./overlays {inherit inputs versions;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    vars = inputs.priv.vars;

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

    homeConfigurations = {
      "moi@bon" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./hm/home.nix
          inputs.nix-index-database.hmModules.nix-index
        ];
      };
    };
  };
}
