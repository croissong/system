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

      kubeswitch = prev.kubeswitch.overrideAttrs (_: {
        version = "0.9.1-next";
        src = prev.fetchFromGitHub {
          owner = "danielfoehrKn";
          repo = "kubeswitch";
          rev = "master";
          hash = "sha256-/vN4oh5dyqHDiBAMV4Zt9PWoIXmlc5LWOMsW1npz9Fc=";
        };

        doCheck = false;
      });

      gitwatch = final.writeShellApplication {
        name = "gitwatch";
        runtimeInputs = with final.pkgs; [
          git
          inotify-tools
          openssh
          coreutils
          gnugrep
          gnused

          # for custom pre-commit hook
          bash
          eza
        ];

        bashOptions = [
          "errexit"
          "pipefail"
        ];
        checkPhase = "";
        text = builtins.readFile (
          builtins.fetchurl {
            url = "https://raw.githubusercontent.com/croissong/gitwatch/master/gitwatch.sh";
          }
        );
      };

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

  tree-grepper = final: _prev: {
    tree-grepper = {
      system = final.system;
      overlays = [ (import inputs.tree-grepper.overlay) ];
    };
  };
}
