{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
    }:
    let
      name = "mbp";
      hosts = import ./hosts;
      configuration =
        { pkgs, ... }:
        {
          nix.settings.experimental-features = "nix-command flakes";

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;
          nixpkgs.hostPlatform = "aarch64-darwin";
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

          users.users."niccoloborgioli" = {
            home = "/Users/niccoloborgioli";
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
        };
    in
    {
      darwinConfigurations."${name}" = nix-darwin.lib.darwinSystem {
        modules = [
          (
            { config, ... }:
            {
              config._module.args = { inherit hosts; };
            }
          )
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.niccoloborgioli = import ./home.nix;
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      # darwinPackages = self.darwinConfigurations."${name}".pkgs;
    };
}
