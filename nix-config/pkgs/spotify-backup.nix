{
  fetchFromGitHub,
  python3Packages,
}:
python3Packages.buildPythonApplication rec {
  pname = "spotify-backup";
  version = "v0.1";

  src = fetchFromGitHub rec {
    inherit pname version;
    name = pname;
    rev = "master";
    owner = "caseychu";
    repo = "spotify-backup";
    sha256 = "sha256-+z9IWgtc71GPPLDqNU4PXFDyD5Dczp3Bbrwzy/DaIts=";
  };

  phases = ["unpackPhase" "installPhase" "postFixup"];
  format = "other";
  installPhase = ''
    install -Dm755 spotify-backup.py $out/bin/spotify-backup
  '';
}
