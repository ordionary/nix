{ pkgs }:
with pkgs;
[
  # Base
  tmux
  oh-my-posh
  git
  git-lfs
  git-crypt
  gh
  bfg-repo-cleaner
  gnutar
  gnupg
  htop
  btop
  rclone
  rename
  tmux
  tree
  wget
  woff2
  rsync
  yq

  # Rust utils
  bat
  eza
  ripgrep
  ripgrep-all
  zoxide
  uutils-coreutils-noprefix
  dust
  yazi

  # Dev
  devenv
  nixpacks
  ollama
  colima
  lazydocker
  exercism

  # Editor
  neovim
  fzf
  lazygit
  lua
  luajitPackages.luarocks
  ast-grep

  # Language specific
  nixfmt-rfc-style
  fnm
  bun
  deno
  zig
  uv
  ruff
  tectonic
  tex-fmt
  rustup
  shfmt
  go

  # Fonts
  nerd-fonts.jetbrains-mono
]
