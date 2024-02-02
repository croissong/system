{
  config,
  outputs,
  pkgs,
  ...
}: {
  services = {
    strongswan-swanctl = {
      enable = true;
      strongswan.extraConfig = ''
        charon {
          plugins {
            resolve {
              load = false
            }
          }
        }
      '';
      swanctl = {
        connections = {
          vpn-wrk = {
            vips = ["0.0.0.0" "::"];
            remote_addrs = [outputs.vars.wrk.vpnRemoteAddress];
            local.moi = {
              eap_id = "jm";
              # openssl pkcs12 -in vpn.p12 -clcerts -nokeys
              certs = [config.sops.secrets."wrk/vpn/cert".path];
            };
            remote.wrk = {
              auth = "pubkey";
              # openssl pkcs12 -in vpn.p12 -cacerts -nokeys
              cacerts = [config.sops.secrets."wrk/vpn/cacert".path];
            };
            children.vpn-wrk.remote_ts = ["10.0.0.0/8"];
          };
        };

        # openssl pkcs12 -in vpn.p12 -nodes -nocerts
        secrets.private.vpn-wrk.file = config.sops.secrets."wrk/vpn/key".path;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    strongswan # for swanctl
  ];
}
