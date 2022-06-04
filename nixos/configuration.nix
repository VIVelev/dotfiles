{ config, pkgs, ... }:

{
  imports = 
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # For running the VM on hidpi machines (retina displays, etc).
  hardware.video.hidpi.enable = true;
  # I use Parallels as a VM, so enable the sweet integration (copy-paste, etc).
  # NOTE: Waiting for https://github.com/NixOS/nixpkgs/pull/153665
  hardware.parallels.enable = false;

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    channel = https://nixos.org/channels/nixos-unstable;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking.hostName = "dev";
  
  time.timeZone = "America/New_York";
  
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replecated the default behaiour.
  networking.useDHCP = false;
  # This is the interface on my M1.
  networking.interfaces.enp0s5.useDHCP = true;
  
  # Select internation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Setup windowing environment.
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      wallpaper.mode = "fill";
    };

    displayManager = {
      defaultSession = "none+xmonad";
      lightdm.enable = true;
      autoLogin = {
        enable = true;
        user = "vivelev";
      };

      # Set key repeat rate.
      sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset r rate 200 40
      '';
    };

    windowManager = {
      xmonad.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # atuin
    bat
    exa
    fd
    fish
    fzf
    gcc
    git
    gnumake
    gnupg
    neovim
    ripgrep
    stow
    zoxide

    # GUIs
    kitty
    firefox

    (writeShellScriptBin "xrandr-auto" ''
      xrandr --output Virtual-1 --auto
    '')
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  users.mutableUsers = false;
  users.users.vivelev = {
    isNormalUser = true;
    description = "vivelev";
    password = "qwerty";
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };
  users.users.root.initialPassword = "root";

  services.openssh = {
    enable = true;
    passwordAuthentication = true;
    permitRootLogin = "yes";
  };
  
  system.stateVersion = "22.05";
}
