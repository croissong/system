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
    rev = "8507cceefa155f47a54199db50a2d513c8b95549";
    owner = "caseychu";
    repo = "spotify-backup";
    sha256 = "sha256-jxddRSuSDVENX5bcGdD9l1Zq/I+6MhhH7Apw4cuUUPA=";
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
