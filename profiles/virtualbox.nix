{ pkgs, ... }:

{
  # Workaround: https://discourse.nixos.org/t/issue-with-virtualbox-in-24-11/57607/2
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];
  virtualisation.virtualbox.host.enable = true;
}
