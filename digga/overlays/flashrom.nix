final: prev: {
flashrom = prev.flashrom.overrideAttrs (prevAttrs: {
              src = prev.pkgs.fetchzip {
                url = "https://download.flashrom.org/releases/flashrom-v${prevAttrs.version}.tar.bz2";
                hash = "sha256-rXwD8kpIrmmGJQu0NHHjIPGTa4+xx+H0FdqwAwo6ePg=";
              };

              nativeBuildInputs = prevAttrs.nativeBuildInputs ++ (with prev.pkgs; [
                meson
                ninja
              ]);

              buildInputs = prevAttrs.buildInputs ++ (with prev.pkgs; [
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
            });

}
