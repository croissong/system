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
    sha256 = "sha256-u7BJvQhx7Y+DE/Tmzq/XCPVmtHCztyhiDVKR7fLvd0A=";
  };

  phases = [
    "unpackPhase"
    "installPhase"
    "postFixup"
  ];
  format = "other";
  installPhase = ''
    install -Dm755 spotify-backup.py $out/bin/spotify-backup
  '';
}
