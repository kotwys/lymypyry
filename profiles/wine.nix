{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.wineWowPackages.stable
  ];
}
