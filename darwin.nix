{ flake }:
{ pkgs, host, ... }:
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

  # Security
  system.defaults.screensaver.askForPassword = true;
  system.defaults.screensaver.askForPasswordDelay = 0;
  system.defaults.loginwindow.GuestEnabled = false;

  # Dock
  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "left";
  system.defaults.dock.show-recents = false;
  system.defaults.dock.persistent-apps = [
    "/Applications/Arc.app"
    "/Applications/Ghostty.app"
    "/Applications/VSCodium.app"
    "/Applications/Spotify.app"
    "/System/Applications/System Settings.app"
  ];
  system.defaults.dock.persistent-others = [ ];

  # Input devices
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 25;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;
  system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
  system.defaults.NSGlobalDomain."com.apple.trackpad.scaling" = 0.875;
  system.defaults.trackpad.Dragging = true;

  # Finder
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.ShowPathbar = true;

  # Other
  system.startup.chime = false;

  users.users.${host.username} = {
    home = "/Users/${host.username}";
    shell = pkgs.fish;
  };
  programs.fish.enable = true;

  homebrew = {
    enable = true;
    casks = import ./cask.nix;
    taps = [ "lihaoyun6/tap" ];
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
  };

  # Home Manager
  home-manager.backupFileExtension = "backup";
}
