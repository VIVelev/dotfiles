# Hardware configuration.
{ config, lib, pkgs, modulesPath, ... }:

{
  disabledModules = [ "virtualisation/parallels-guest.nix" ];

  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./parallels-guest.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "usbhid"
        "sr_mod"
      ];
      kernelModules = [ "virtio-gpu" ];
    };
    kernelParams = [
      "root=/dev/sda2"
      "video=Virtual-1:4112x2572@60"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ ];
    extraModulePackages = [ ];
    loader = {
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "auto";
      systemd-boot.configurationLimit = 5;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];

  hardware = {
    parallels = {
      enable = true;
      package = (config.boot.kernelPackages.callPackage ./prl-tools.nix { });
    };
    video.hidpi.enable = true;
  };
}
