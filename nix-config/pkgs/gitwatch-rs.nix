{
  rustPlatform,
  pkg-config,
  openssl,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage {
  pname = "gitwatch-rs";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "croissong";
    repo = "gitwatch-rs";
    rev = "wip";
    hash = "sha256-aKk2s8IhnHjoJkXq9ryGn9fN0AmZyVTHbD/Vano+Erw=";
  };
  cargoHash = "sha256-AtfSkFX5hqoZVMn3/ScN4IhH4hr6tqyzx8tK2JkDqCc=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  meta = {

  };
}
