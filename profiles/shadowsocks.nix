{ pkgs, ... }:

let
  shadowsocks = pkgs.shadowsocks-rust;
in
{
  systemd.services.shadowsocks = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    path = [ shadowsocks ];
    script = ''
      exec ssservice local --log-without-time -c /etc/shadowsocks/config.json
    '';
  };
}
