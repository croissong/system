# build directly via
# nix-build -E 'with import <nixpkgs> {}; callPackage ./exportify-cli.nix {}'

{
  fetchFromGitHub,
  python3Packages,
}:
python3Packages.buildPythonApplication rec {
  pname = "exportify-cli";
  version = "v0.5.3";

  src = fetchFromGitHub rec {
    inherit pname version;
    name = pname;
    rev = "1e8613734aa3babb5ae45219e4d094069a0b1eac";
    owner = "donmerendolo";
    repo = "exportify-cli";
    sha256 = "sha256-vfCRwJM8h7SM+3Q58QKtFcPVNYXt1qdv8VYp/cgXv8A=";
  };

  propagatedBuildInputs = with python3Packages; [
    click
    click-option-group
    pathvalidate
    pyinstaller # Skip this - it's only needed for building executables
    requests
    spotipy
    tabulate
    tqdm
  ];

  format = "other";

  patchPhase = ''
    runHook prePatch

    sed -i '1i#!/usr/bin/env python3' exportify-cli.py

    # Add import for os at the top after other imports
    sed -i '/^import /a import os' exportify-cli.py

    # Replace cache path with XDG-compliant path
    substituteInPlace exportify-cli.py \
      --replace 'cache_path=Path(__file__).parent / Path(".cache"),' \
                'cache_path=Path(os.environ.get("XDG_CACHE_HOME", Path.home() / ".cache")) / "exportify-cli",'

    runHook postPatch
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -Dm755 exportify-cli.py $out/bin/exportify-cli

    runHook postInstall
  '';

  postFixup = ''
    wrapPythonPrograms
  '';

  doCheck = false;
}
