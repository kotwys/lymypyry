{ pkgs, lib, ... }:

{
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];

  boot.initrd.luks.devices.crypted = {
    device = "/dev/disk/by-uuid/fe2ddbfe-5c07-4a5e-8e84-f39656373cf0";
    preLVM = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c80ef91a-4e90-4fdd-a875-669c9b2a5aa9";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/05A3-3156";
    fsType = "vfat";
    options = ["umask=0077"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/b346519e-2d43-4ad8-8c3d-cac9653742cb";
    fsType = "ext4";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/dce8134d-487e-41d9-8ce9-68dfc21eee08"; }
  ];

  boot.extraModulePackages = with pkgs.linuxPackages; [ rtl8821cu ];
  hardware.cpu.amd.updateMicrocode = true;

  networking.hostName = "kotwys-pc";
  i18n.defaultLocale = lib.mkForce "fi_FI.UTF-8";

  services.xserver.videoDrivers = [ "amdgpu" ];

  system.stateVersion = "21.05";
}
