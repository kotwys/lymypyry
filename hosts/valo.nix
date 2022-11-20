{ pkgs, lib, ... }:

{
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "amdgpu" "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices.crypted = {
    device = "/dev/disk/by-uuid/317a8f2e-f378-416a-9555-6e7b2a7d74c3";
    preLVM = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b049074c-c7e6-44f0-b512-534e17e0420c";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8FB5-49BC";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/d27d06f2-4902-4a3a-8963-abcfef313f33";
    fsType = "ext4";
  };

  swapDevices = [ 
    { device = "/dev/disk/by-uuid/637fbcc5-4615-4dcd-8d09-4d39a5863d11"; }
  ];

  networking.hostName = "valo";
  
  i18n.defaultLocale = lib.mkForce "ja_JP.UTF-8";

  hardware.cpu.amd.updateMicrocode = true;
  hardware.opengl.driSupport = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
}
