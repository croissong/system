{
  fetchurl,
  versions,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "gtrash";
  version = versions.gtrash.version;
  src = fetchurl {
    url = versions.gtrash.url;
    sha256 = versions.gtrash.sha;
  };

  sourceRoot = ".";
  installPhase = ''
    install -m755 -D gtrash $out/bin/gtrash
  '';

  meta = {
    homepage = "https://github.com/umlx5h/gtrash";
    description = "A Featureful Trash CLI manager: alternative to rm and trash-cli";
  };
}
