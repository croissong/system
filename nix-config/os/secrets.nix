{...}: {
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age.keyFile = "/etc/age/identity.age";
    secrets = {
      hashedPassword = {};
      "wrk/vpn/cert" = {
        format = "binary";
        sopsFile = ../secrets/vpn.cert.pem;
      };
      "wrk/vpn/cacert" = {
        format = "binary";
        sopsFile = ../secrets/vpn.cacert.pem;
      };
      "wrk/vpn/key" = {
        format = "binary";
        sopsFile = ../secrets/vpn.key.pem;
        path = "/etc/swanctl/private/vpn-wrk.key.pem";
      };
      "wrk/vpn/dns-forwarding-rules" = {
        format = "binary";
        sopsFile = ../secrets/vpn-dns-forwarding-rules.txt;
        mode = "444";
      };
    };
  };
}
