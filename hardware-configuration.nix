{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=4G" "mode=755" ];
      neededForBoot = true;
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/4c333d63-56c3-4bce-a3fa-a4ba754676cc";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
      neededForBoot = true;
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/4c333d63-56c3-4bce-a3fa-a4ba754676cc";
      fsType = "btrfs";
      options = [ "subvol=@persist" ];
      neededForBoot = true;
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/4c333d63-56c3-4bce-a3fa-a4ba754676cc";
      fsType = "btrfs";
      options = [ "subvol=@log" ];
      neededForBoot = true;
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E4F2-97A6";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
      neededForBoot = true;
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
