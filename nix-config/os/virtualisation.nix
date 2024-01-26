{...}: {
  virtualisation = {
    podman = {
      # https://nixos.wiki/wiki/Podman

      enable = true;
      autoPrune.enable = true;

      dockerCompat = true;
      dockerSocket.enable = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
