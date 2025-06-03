{
  lib,
  pkgs,
  ...
}:
{
  projectRootFile = ".gitignore";
  programs = {
    black.enable = true;
    cue.enable = true;
    d2.enable = true;
    gofmt.enable = true;
    just.enable = true;
    jsonnet-lint.enable = true;
    jsonnetfmt.enable = true;
    nimpretty.enable = true;
    nixfmt.enable = true;
    opa.enable = true;
    packer.enable = true;
    prettier.enable = true;

    rustfmt.enable = true;

    shellcheck.enable = true;
    shfmt.enable = true;
    stylua.enable = true;
    terraform.enable = true;
  };

  settings.formatter = {
    slint = {
      command = "${lib.getExe pkgs.slint-lsp}";
      options = [
        "format"
        "--inline"
      ];
      includes = [ "*.slint" ];
    };

    rustfmt = {
      # use config from ~/.config/rustfmt/rustfmt.toml

      # wrt skip_children see https://github.com/numtide/treefmt-nix/pull/240
      options = lib.mkForce [
        "--config"
        "skip_children=true"
      ];
    };

    xml = {
      command = "${pkgs.xmlformatter}/bin/xmlformat";
      options = [
        "--blanks"
        "--indent"
        "4"
        "--selfclose"
        "-"
      ];
      includes = [ "*.xml" ];
    };
  };
}
