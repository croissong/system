{ lib, pkgs, ... }:
{
  projectRootFile = ".git/config";
  programs = {
    black.enable = true;
    cue.enable = true;
    d2.enable = true;
    gofmt.enable = true;
    just.enable = true;
    jsonnet-lint.enable = true;
    jsonnetfmt.enable = true;
    nimpretty.enable = true;
    nixfmt-rfc-style.enable = true;
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

    xml = {
      command = "${lib.getExe pkgs.xmlformat}";
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
