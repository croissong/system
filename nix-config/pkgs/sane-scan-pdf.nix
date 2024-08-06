{
  fetchFromGitHub,
  lib,
  makeWrapper,
  pkgs,
  stdenv,
  versions,
}:
stdenv.mkDerivation rec {
  pname = "sane-scan-pdf";
  version = versions.sane-scan-pdf.version;
  src = fetchFromGitHub {
    owner = "rocketraman";
    repo = "sane-scan-pdf";
    rev = "v${version}";
    hash = "sha256-WGtg+B11lKjTwTVICldz16UfjAk4l7pftukbfXb3S3c=";
  };

  nativeBuildInputs = [makeWrapper];
  # https://github.com/rocketraman/sane-scan-pdf/wiki/Dependencies-Installation
  buildInputs = with pkgs; [bash netpbm coreutils ghostscript poppler_utils imagemagick unpaper util-linux tesseract parallel units bc sane-frontends];

  installPhase = ''
    install -m755 -D scan $out/bin/scan-pdf
    install -m755 -D scan_perpage $out/bin/scan_perpage # needs to be this exact name

    wrapProgram $out/bin/scan-pdf --prefix PATH : '${lib.makeBinPath buildInputs}'
  '';

  meta = {
    homepage = "https://github.com/rocketraman/sane-scan-pdf";
    description = "Sane command-line scan-to-pdf script on Linux with OCR and deskew support";
  };
}
