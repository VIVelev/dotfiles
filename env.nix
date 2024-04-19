with import <nixpkgs>
  { overlays = [
      # (import (builtins.fetchTarball { url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz; }))
    ];
  }; [
  bat
  bash
  bitwarden-cli
  btop
  direnv
  eza
  fd
  ffmpeg
  fish
  fzf
  gh
  gnumake
  imagemagick
  ghostscript # for pdf -> png conversion
  # hatch
  micromamba
  neovim
  nix-direnv
  nil
  nodejs
  ripgrep
  stow
  typst
  typst-lsp
  zoxide

  # node packages
  nodePackages_latest.webtorrent-cli
  nodePackages_latest.live-server
]
