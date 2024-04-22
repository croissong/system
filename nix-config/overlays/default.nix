{
  inputs,
  versions,
  ...
}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev:
    import ../pkgs {
      pkgs = final;
      versions = versions;
    };

  modifications = final: prev: {
    flashrom = import ./flashrom.nix {inherit final prev;};

    termdown = prev.termdown.overrideAttrs (oldAttrs: rec {
      version = "1.18.0";
      src = final.fetchFromGitHub {
        rev = version;
        sha256 = "sha256-Hnk/MOYdbOl14fI0EFbIq7Hmc7TyhcZWGEg2/jmNJ5Y=";
        repo = "termdown";
        owner = "trehn";
      };
    });
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  nixpkgs-pr = final: _prev: {
    nixpkgs-pr = import inputs.nixpkgs-pr {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  emacs-overlay = final: _prev: {
    emacs-overlay = import inputs.nixpkgs {
      system = final.system;
      config.allowUnfree = true;
      overlays = [(import inputs.emacs-overlay)];
    };
  };

  tree-grepper = final: _prev: {
    tree-grepper = {
      system = final.system;
      overlays = [(import inputs.tree-grepper.overlay)];
    };
  };
}
