{
  pkgs,
  host,
  flake,
  lib,
  ...
}:
{
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = flake.rev or flake.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
  nixpkgs.hostPlatform = host.platform;
  nixpkgs.config.allowUnfree = true;

  # Nix Darwin
  # https://daiderd.com/nix-darwin/manual/index.html

  # networking.hosts = {
  #   "127.0.0.1" = [
  #     "localhost"
  #     "dev.buena.com"
  #   ];
  # };

  system.defaults = {
    # Security
    screensaver.askForPassword = true;
    screensaver.askForPasswordDelay = 0;
    loginwindow.GuestEnabled = false;

    # Dock
    dock = {
      autohide = true;
      orientation = "left";
      show-recents = false;
      persistent-apps = [
        "/Applications/Arc.app"
        "/Applications/Ghostty.app"
        "/Applications/VSCodium.app"
        "/Applications/Spotify.app"
        "/System/Applications/System Settings.app"
      ];
      persistent-others = [ ];
    };

    # Finder
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
    };

    # Trackpad
    NSGlobalDomain = {
      InitialKeyRepeat = 25;
      KeyRepeat = 2;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.trackpad.scaling" = 0.875;
    };
    trackpad = {
      Dragging = true;
      Clicking = true;
      TrackpadRightClick = true;
    };
  };

  # Input devices
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  # Other
  system.startup.chime = false;

  users.users.${host.username} = {
    home = "/Users/${host.username}";
    shell = pkgs.fish;
  };
  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];

  homebrew = {
    enable = true;
    casks = (import ./cask.nix) ++ (lib.attrByPath [ "extras" "casks" ] [ ] host);
    taps = [ "lihaoyun6/tap" ];
    global = {
      autoUpdate = true;
    };
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
  };
}
