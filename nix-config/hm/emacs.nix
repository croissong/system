{
  pkgs,
  ...
}:
let
  package =
    with pkgs;
    (nixpkgs-nixos-unstable.emacsPackagesFor emacs-overlay.emacs-unstable-pgtk).emacsWithPackages (
      epkgs: with epkgs; [
        jinx
        auctex
        treesit-grammars.with-all-grammars
        customGrammars
        vterm

        # https://codeberg.org/divyaranjan/emacs-reader/issues/115
        # https://github.com/shanyouli/nur-packages/blob/master/pkgs/emacs/emacs-reader.nix
        (melpaBuild {
          pname = "reader";
          version = "20260515";
          src = fetchFromGitea {
            domain = "codeberg.org";
            owner = "MonadicSheep";
            repo = "emacs-reader";
            rev = "7792885f28e65d8b413c3aaefa8ad9d467c7bd5f";
            hash = "sha256-3jkbEUOXOlKIMTBihEUWgF9+nq7tnYWGO449H7XM9vQ=";
          };
          files = ''(:defaults "render-core.so")'';
          nativeBuildInputs = [ pkg-config ];
          buildInputs = [
            gcc
            mupdf
            gnumake
            pkg-config
          ];
          preBuild = ''
            export EMACSLOADPATH=".:$EMACSLOADPATH"
            make clean all CC=$CC USE_PKGCONFIG=yes
          '';
        })
      ]
    );

  treesitter-cooklang-grammar = pkgs.tree-sitter.buildGrammar {
    language = "cooklang";
    version = "0.0.0+rev=master";
    src = pkgs.fetchFromGitHub {
      owner = "cooklang";
      repo = "tree-sitter-cooklang";
      rev = "master";
      hash = "sha256-VeAHKf2qp2ApKMXWEqI8LUA9KYvxlZL/u6TlOlfmKLs=";
    };
    meta.homepage = "https://github.com/cooklang/tree-sitter-cooklang";
  };

  customGrammars = pkgs.linkFarm "treesit-grammars" [
    {
      name = "lib/libtree-sitter-cooklang${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}";
      path = "${treesitter-cooklang-grammar}/parser";
    }
  ];
in
{
  services.emacs = {
    enable = true;
    package = package;
    client = {
      enable = true;
      arguments = [ "-r" ];
    };
    defaultEditor = true;
    startWithUserSession = "graphical";
  };

  home.packages = [
    package
    pkgs.emacs-lsp-booster
  ];
}
