{ host }:
{
  pkgs,
  lib,
  config,
  sops-nix,
  ...
}:
{
  # https://nix-community.github.io/home-manager
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.username = host.username;
  home.homeDirectory = "/Users/${host.username}";

  home.packages =
    [ ]
    ++ (import ./home/shared.nix { inherit pkgs; })
    # TODO: Move to host config
    ++ lib.optionals (host.hostName == "sflx") (import ./home/sflx.nix { inherit pkgs; });

  fonts.fontconfig.enable = true;

  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };

    file = {
      ".config/omp/config.yaml".source = ./files/omp/config.yaml;
      ".config/ghostty/config".source = ./files/ghostty/config;
      ".gitconfig".source = ./files/git/gitconfig;
      ".gitignore_global".source = ./files/git/gitignore_global;
      ".gitconfig.local".source = ./files/git/config.work;
      ".config/nvim".source = ./files/nvim;
    };

    shellAliases = {
      l = "ls -hal";
      dc = "docker compose";
      rsync = "rsync -az --info=progress2";
      t = "tmux new-session -A -s main";
      e = "nvim";
      vai = "darwin-rebuild switch --flake ~/.config/nix-darwin#${host.hostName}";
    };
  };

  programs = {
    direnv.enable = true;
    zoxide.enable = true;

    fish = {
      enable = true;
      interactiveShellInit = ''
        if type -q oh-my-posh
          oh-my-posh init fish --config ~/.config/omp/config.yaml | source
        end
        if type -q fnm
          fnm env --use-on-cd | source
        end
      '';
    };
    bash = {
      enable = true;
    };
    tmux = {
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
  };

  # Secrets
  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets/ssh.yaml;
    secrets.config = {
      mode = "0600";
      path = "${config.home.homeDirectory}/.ssh/config";
    };
  };

}
