# https://git.sr.ht/~r-vdp/nixos-config/tree/main/item/package-overrides.nix
{
  final,
  prev,
}:
prev.flashrom.overrideAttrs (
  finalAttrs: prevAttrs: {
    src = final.fetchzip {
      url = "https://download.flashrom.org/releases/flashrom-v${finalAttrs.version}.tar.xz";
      hash = "sha256-uUXWtopl3KCBUX15GhPUWO10ob7azocnjiXKgvIRdlI=";
    };

    nativeBuildInputs =
      prevAttrs.nativeBuildInputs
      ++ (with final; [
        meson
        ninja
      ]);

    buildInputs =
      prevAttrs.buildInputs
      ++ (with final; [
        cmocka
      ]);

    mesonFlags = [
      "-Dprogrammer=auto"
    ];

    postInstall =
      let
        udevRulesPath = "lib/udev/rules.d/flashrom.rules";
      in
      ''
        # After the meson build, the udev rules file is no longer present
        # in the build dir, so we need to get it from $src and patch it
        # again.
        # There might be a better way to do this...
        install -Dm644 $src/util/flashrom_udev.rules $out/${udevRulesPath}
        substituteInPlace $out/${udevRulesPath} \
          --replace 'GROUP="plugdev"' 'TAG+="uaccess", TAG+="udev-acl"'
      '';
  }
)
