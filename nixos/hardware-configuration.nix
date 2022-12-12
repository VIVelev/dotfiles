# Hardware configuration.
{ config, lib, pkgs, modulesPath, ... }:

{
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

  hardware.parallels = {
    enable = true;
    package = with pkgs; (config.boot.kernelPackages.prl-tools.overrideAttrs (old:
      let
        version = "18.1.0-53311";
        src = fetchurl {
          url = "https://download.parallels.com/desktop/v${lib.versions.major version}/${version}/ParallelsDesktop-${version}.dmg";
          sha256 = "sha256-2ROPFIDoV2/sMVsVhcSyn0m1QVMCNb399WzKd/cozws=";
        };
        patches = lib.optionals (lib.versionAtLeast config.boot.kernelPackages.kernel.version "6.0") [
          # ./prl-tools-6.0.patch
        ];
      in
      { inherit version src patches; }
    ));
  };

  hardware.video.hidpi.enable = true;

  systemd.services.prlshprint.serviceConfig.Type = lib.mkForce "simple";
}
