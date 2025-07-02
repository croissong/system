{
  inputs,
  versions,
  ...
}:
let
  importPackage = pkg: final: _prev: {
    ${pkg} = import inputs.${pkg} {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  nixpkgsInputs = builtins.filter (input: builtins.match "^nixpkgs-.*" input != null) (
    builtins.attrNames inputs
  );

  generatedImports = builtins.listToAttrs (
    builtins.map (pkg: {
      name = pkg;
      value = importPackage pkg;
    }) nixpkgsInputs
  );
in
generatedImports
// {

  # This one brings our custom packages from the 'pkgs' directory
  additions =
    final: _prev:
    import ../pkgs {
      pkgs = final;
      system = final.system;
      inherit inputs versions;
    };

  modifications =
    final: prev:
    let
      rustOverlay = import ./rust.nix { inherit final prev; };
    in
    rustOverlay
    // {

      imports = [
        ./rust.nix
      ];

      flashrom = import ./flashrom.nix { inherit final prev; };

      termdown = prev.termdown.overrideAttrs (_: rec {
        version = "1.18.0";
        src = final.fetchFromGitHub {
          rev = version;
          sha256 = "sha256-Hnk/MOYdbOl14fI0EFbIq7Hmc7TyhcZWGEg2/jmNJ5Y=";
          repo = "termdown";
          owner = "trehn";
        };
      });
    };

  emacs-overlay = final: _prev: {
    emacs-overlay = import inputs.nixpkgs-nixos-unstable {
      system = final.system;
      config.allowUnfree = true;
      overlays = [ (import inputs.emacs-overlay) ];
    };
  };

  tree-grepper = final: prev: {
    tree-grepper = final.callPackage inputs.tree-grepper.overlay { };
  };

  je = final: prev: {
    je = inputs.je.packages.${final.system}.default;
  };

  esplanade = final: prev: {
    esplanade = inputs.esplanade.packages.${final.system}.default;
  };

  gitwatch-rs = final: prev: {
    gitwatch-rs = inputs.gitwatch-rs.packages.${final.system}.default;
  };
}
