{ pkgs, ... }:

let
  inherit (pkgs) v2ray;
in
{
  systemd.packages = [ v2ray ];

  systemd.services.v2ray = {
    # https://github.com/NixOS/nixpkgs/issues/81138
    wantedBy = [ "multi-user.target" ];
  };
}
