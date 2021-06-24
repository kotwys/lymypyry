{ pkgs, ... }:

{
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/de3a2abe-a754-4139-b491-310cce895a67";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/05A3-3156";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/55f6eae9-bdc4-45ec-b785-b2805d8fc7f5";
    fsType = "ext4";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/adf2e8bc-1d99-424c-969d-1da8e6647f22"; }
  ];

  boot.extraModulePackages = with pkgs.linuxPackages; [ rtl8821cu ];
  hardware.cpu.amd.updateMicrocode = true;

  networking.hostName = "kotwys-pc";

  services.xserver.videoDrivers = [ "amdgpu" ];

  system.stateVersion = "21.05";
}
