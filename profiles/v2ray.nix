{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.v2raya ];

  systemd.services.v2raya = {
    description = "v2rayA";
    after = [ "network.target" "iptables.service" ];
    wants = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    path = builtins.attrValues {
      inherit (pkgs) iptables bash;
    };

    /* https://github.com/NixOS/nixpkgs/blob/nixos-24.05/nixos/modules/services/networking/v2raya.nix */
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.v2raya}/bin/v2rayA --log-disable-timestamp";
      Environment = [ "V2RAYA_LOG_FILE=/var/log/v2raya/v2raya.log" ];
      User = "root";
      LimitNPROC = 500;
      LimitNOFILE = 1000000;
      Restart = "on-failure";
    };
  };
}
