{
  stdenv,
  fetchFromGitHub,
  versions,
}:
stdenv.mkDerivation rec {
  pname = "sane-scan-pdf";
  version = versions.sane-scan-pdf.version;
  src = fetchFromGitHub {
    owner = "rocketraman";
    repo = "sane-scan-pdf";
    rev = "v${version}";
    sha256 = versions.sane-scan-pdf.sha;
  };

  installPhase = ''
    install -m755 -D scan $out/bin/scan
    install -m755 -D scan_perpage $out/bin/scan_perpage
  '';

  meta = {
    homepage = "https://github.com/rocketraman/sane-scan-pdf";
    description = "Sane command-line scan-to-pdf script on Linux with OCR and deskew support";
  };
}
