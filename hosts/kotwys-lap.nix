{ pkgs, ... }:

{
  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/8c4a52e0-68df-4b94-a967-9c7bdecb8176";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/2ee519cd-25a3-46a7-a8f7-8a8f85e062df";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/fa1fab7c-2189-4c50-adf4-d19e6d5a4cce"; }
    ];

  networking.hostName = "kotwys-lap"; 
}
