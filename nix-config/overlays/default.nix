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

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # TODO: PR for https://github.com/NixOS/nixpkgs/issues/237886
    kubeswitch = prev.kubeswitch.overrideAttrs (oldAttrs: {
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [final.installShellFiles];

      postInstall = ''
        mv $out/bin/main $out/bin/switcher
        mkdir $out/share
        $out/bin/switcher init zsh > $out/share/switch.zsh
        installShellCompletion --cmd switch --zsh <($out/bin/switcher completion --cmd switch zsh)
      '';

      doCheck = false;
    });

    termdown = prev.termdown.overrideAttrs (oldAttrs: rec {
      version = "1.18.0";
      src = final.fetchFromGitHub {
        rev = version;
        sha256 = "sha256-Hnk/MOYdbOl14fI0EFbIq7Hmc7TyhcZWGEg2/jmNJ5Y=";
        repo = "termdown";
        owner = "trehn";
      };
    });

    tessen = prev.tessen.overrideAttrs (oldAttrs: {
      version = "2.2.1-next";

      src = final.fetchFromSourcehut {
        owner = "~ayushnix";
        repo = oldAttrs.pname;
        rev = "master";
        sha256 = "sha256-Kn9d7/xtdhDACANU4NlS+Ap8boHGbZfN6yAfPcRs0tA=";
      };
    });

    systemctl-tui = prev.systemctl-tui.override (oldAttrs: {
      rustPlatform.buildRustPackage = args:
        final.rustPlatform.buildRustPackage (
          args
          // rec {
            cargoHash = "sha256-X9+zbNJYma7pbXVWdF+poeFTPXRRWcAvQsqiO4dRt58=";
            version = "0.3.1";
            src = final.fetchCrate {
              pname = args.pname;
              version = version;
              hash = "sha256-kioQvtHpKg4/oY5IWQd29dGkRnXNjvE0wKea1s7i5MA=";
            };
          }
        );
    });
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
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
