{ config, pkgs, ... }:

{
  # https://nix-community.github.io/home-manager
  home.stateVersion = "24.11"; # Please read the comment before changing.
  programs.home-manager.enable = true;

  home.username = "niccoloborgioli";
  home.homeDirectory = "/Users/niccoloborgioli";

  home.packages = [
    pkgs.tmux
    pkgs.oh-my-posh
    pkgs.git
    pkgs.git-lfs
    pkgs.git-crypt
    pkgs.bfg-repo-cleaner
    pkgs.gnutar
    pkgs.gnupg
    pkgs.htop
    pkgs.rclone
    pkgs.rename
    pkgs.tmux
    pkgs.tree
    pkgs.wget
    pkgs.woff2
    pkgs.bat
    pkgs.rsync
    pkgs.direnv
    pkgs.zoxide

    # Editor
    pkgs.neovim
    pkgs.fzf
    pkgs.lazygit
    pkgs.lua
    pkgs.luajitPackages.luarocks
    pkgs.ast-grep
    pkgs.ripgrep

    # Language specific
    pkgs.nixfmt-rfc-style
    pkgs.fnm
    pkgs.bun
    pkgs.deno
    pkgs.zig
    # Python
    pkgs.uv
    pkgs.ruff
    pkgs.tectonic

    # Codding
    pkgs.nixpacks

    # sflx
    pkgs.vault
    pkgs.cocoapods
    pkgs.phrase-cli

    pkgs.nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file = {
    ".config/omp/config.yaml".source = ./files/omp/config.yaml;
    ".config/ghostty/config".source = ./files/ghostty/config;
    ".config/kitty".source = ./files/kitty;
    ".gitconfig".source = ./files/git/gitconfig;
    ".gitignore_global".source = ./files/git/gitignore_global;
    ".config/nvim".source = ./files/nvim;
  };

  home.shellAliases = {
    l = "ls -hal";
    dc = "docker compose";
    rsync = "rsync -az --info=progress2";
    t = "tmux new-session -A -s main";
    e = "nvim";
    hms = "home-manager switch --flake ~/nix#root -b backup";
    snd = "darwin-rebuild switch --flake ~/.config/nix-darwin#sflx";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if type -q oh-my-posh
        oh-my-posh init fish --config ~/.config/omp/config.yaml | source
      end
      if type -q fnm
        fnm env --use-on-cd | source
      end
      if type -q direnv
        direnv hook fish | source
      end
      if type -q zoxide
        zoxide init fish | source
      end
    '';
  };
  programs.bash = {
    enable = true;
  };
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    extraConfig = ''
      # switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # switch panes using jkhl
      bind h select-pane -L
      bind l select-pane -R
      bind j select-pane -U
      bind k select-pane -D
    '';
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
  };

}
