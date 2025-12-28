{ pkgs, ... }:

{
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
  };
  users.users.kotwys.extraGroups = [ "libvirtd" ];
  environment.systemPackages = [ pkgs.virtiofsd ];
}
