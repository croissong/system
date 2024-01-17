{
  stdenv,
  fetchFromGitHub,
}: let
  # versions = builtins.fromJSON (builtins.readFile (./. + "/versions.json"));
  version = "0.2";
  sha = "14anhn0k8z7179ibzx8my40awcgc7n47rf5pzzcnp2qca3c87r9a";
in
  stdenv.mkDerivation rec {
    name = "gitwatch";
    # version = version;
    src = fetchFromGitHub {
      owner = "gitwatch";
      repo = "gitwatch";
      rev = "v${version}";
      sha256 = sha;
    };

    installPhase = ''
      install -m755 -D gitwatch.sh $out/bin/gitwatch
    '';

    meta = {
      homepage = "https://github.com/gitwatch/gitwatch";
      description = "Watch a file or folder and automatically commit changes to a git repo easily.";
    };
  }
