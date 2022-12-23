{ config, pkgs, ... }:

{
  system.defaults.NSGlobalDomain = {
    InitialKeyRepeat = 10;
    KeyRepeat = 1;
  };

  nixpkgs.overlays = [
    # I am usually using neovim nightly
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  programs.zsh.enable = true;
  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
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
    fzf
    gh
    glances
    gnumake
    neovim-nightly
    ripgrep
    stow
    zoxide

    # node packages
    nodePackages_latest.webtorrent-cli
  ];

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  homebrew = {
    enable = true;
    casks = [
      "betterdisplay"
      "iina"
      "keycastr"
      "kitty"
      "mullvadvpn"
      "onyx"
      "orion"
      "raycast"
      "readdle-spark"
      "rectangle"
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
  nix.package = pkgs.nix;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
