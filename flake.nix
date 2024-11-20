{
  description = "Example nix-darwin system flake";

  inputs = {
    # https://github.com/LnL7/nix-darwin/issues/1176
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/8809585e6937d0b07fc066792c8c9abf9c3fe5c4";

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
          environment.systemPackages = [ ];

          system.defaults.dock.autohide = true;
          system.defaults.dock.orientation = "left";
          system.defaults.finder.AppleShowAllExtensions = true;
          system.keyboard.enableKeyMapping = true;
          system.keyboard.remapCapsLockToEscape = true;
          system.defaults.NSGlobalDomain.InitialKeyRepeat = 25;
          system.defaults.NSGlobalDomain.KeyRepeat = 2;
          system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
          system.defaults.NSGlobalDomain."com.apple.trackpad.scaling" = 0.875;
          system.defaults.trackpad.Dragging = true;

          users.users."niccoloborgioli" = {
            home = "/Users/niccoloborgioli";
            shell = pkgs.fish;
          };
          programs.fish.enable = true;

          homebrew.enable = true;
          homebrew.casks = import ./cask.nix;
          # homebrew.taps = [
          #   "hashicorp/tap"
          # ];
          # homebrew.brews = [
          #   "hashicorp/tap/vault"
          # ];

          # Home Manager
          home-manager.backupFileExtension = "backup";
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Niccolo-Borgioli-s-MacBook-Pro
      darwinConfigurations."sflx" = nix-darwin.lib.darwinSystem {
        modules = [
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
      darwinPackages = self.darwinConfigurations."sflx".pkgs;
    };
}
