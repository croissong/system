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

  additions =
    final: _prev:
    import ../pkgs {
      pkgs = final;
      inherit versions;
    };

  lix = final: _prev: {
    inherit (final.lixPackageSets.stable)
      # nixpkgs-review
      # nix-direnv
      nix-eval-jobs
      nix-fast-build
      colmena
      ;
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
