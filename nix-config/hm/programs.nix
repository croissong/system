{pkgs, ...}: {
  programs = {
    chromium = {
      enable = true;
    };

    nix-index-database = {
      comma.enable = true;
    };
    # disable command-not-found integration
    nix-index.enableFishIntegration = false;
    command-not-found.enable = false;

    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
      mutableExtensionsDir = false;
      extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "slint";
          publisher = "Slint";
          version = "1.7.1";
          hash = "sha256-5fxiN1WFdpFhiQxDgwuwdtNi3eCl/MjEEhN3xREqf70=";
        }
      ];
    };
  };
}
