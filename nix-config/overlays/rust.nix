{
  final,
  prev,
}:
let
in
{

  # desed = prev.desed.override (oldAttrs: {
  #   rustPlatform.buildRustPackage =
  #     args:
  #     final.rustPlatform.buildRustPackage (
  #       args
  #       // rec {
  #         cargoHash = "sha256-3bkNirrvBOqIOhxD5xf3XsdaUMWFVT/lnN3gmZQIB9I=";

  #         version = "1.2.2";
  #         src = final.fetchFromGitHub {
  #           owner = "SoptikHa2";
  #           repo = "desed";
  #           rev = "refs/tags/v${version}";
  #           hash = "sha256-aKkOs8IhnHjoJkXq9ryGn9fN0AmZyVTHbD/Vano+Erw=";
  #         };

  #         # src = final.fetchCrate {
  #         #   pname = args.pname;
  #         #   version = version;
  #         #   hash = "sha256-kioQvtHpKg4/oY5IWQd29dGkRnXNjvE0wKea1s7i5MA=";
  #         # };
  #       }
  #     );
  # });
}
