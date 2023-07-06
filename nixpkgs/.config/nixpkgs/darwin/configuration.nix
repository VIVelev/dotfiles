{ config, pkgs, lib, ... }:

{
  system.defaults.NSGlobalDomain = {
    InitialKeyRepeat = 10;
    KeyRepeat = 1;
  };

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (
      import (let
        # rev = "master";
        rev = "c57746e2b9e3b42c0be9d9fd1d765f245c3827b7";
      in
        builtins.fetchTarball {
          url = "https://github.com/nix-community/neovim-nightly-overlay/archive/${rev}.tar.gz";
        })
    )
  ];

  programs.zsh.enable = true;
  programs.fish.enable = true;
  environment.loginShell = "${pkgs.fish}/bin/fish -l";
  environment.variables.SHELL = "${pkgs.fish}/bin/fish";

  environment.systemPackages = with pkgs; [
    atuin
    bat
    bitwarden-cli
    direnv
    exa
    fd
    fish
    ffmpeg
    fzf
    gh
    gnumake
    htop
    neovim-nightly
    ripgrep
    stow
    zoxide
    nodejs

    # node packages
    nodePackages_latest.webtorrent-cli
  ];

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    casks = [
      "activitywatch"
      "betterdisplay"
      "iina"
      "keycastr"
      "kitty"
      "mactex-no-gui"
      "onyx"
      "raycast"
      "readdle-spark"
      "rectangle"
      "skim"
      "stats"
      "telegram"

      "google-chrome"
      "zoom"
    ];
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixUnstable;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
