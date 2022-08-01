{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # This is the interface on my M1 in VM.
  networking.interfaces.enp0s5.useDHCP = true;

  networking.hostName = "dev";
  networking.firewall.allowedTCPPorts = [ 3000 8000 8080 ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    extraOptions = ''
      experimental-features = nix-command
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
  
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    channel = "https://nixos.org/channels/nixos-unstable";
  };
  
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Setup windowing environment.
  services.xserver = {
    enable = true;
    dpi = 254;

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
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };

  # I am usually using neovim nightly
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  environment.systemPackages = with pkgs; [
    atuin
    bat
    bitwarden-cli
    direnv
    dmenu  # Used by xmonad
    exa
    fd
    fish
    fzf
    gcc  # Used by many
    git
    git-crypt
    gh
    gnumake
    neovim-nightly
    ripgrep
    stow
    xclip  # Copy/paste to/from clipboard
    zoxide

    # GUIs
    kitty
    firefox
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  users.mutableUsers = false;
  users.users.vivelev = {
    isNormalUser = true;
    description = "vivelev";
    password = "root";
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
