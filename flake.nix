{
  description = "Personal Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      sops-nix,
    }:
    let
      hosts = import ./hosts;
      inherit (builtins) listToAttrs;
    in
    {
      darwinConfigurations = listToAttrs (
        map (host: {
          name = host.hostName;
          value = nix-darwin.lib.darwinSystem {
            specialArgs = {
              inherit sops-nix;
              inherit host;
              flake = self;
            };
            modules = [
              (import ./darwin.nix)
              sops-nix.darwinModules.sops
              home-manager.darwinModules.home-manager
              {
                home-manager.sharedModules = [ sops-nix.homeManagerModules.sops ];
                home-manager.backupFileExtension = "backup";
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${host.username} = import ./home.nix { inherit host; };
              }
            ];
          };
        }) hosts
      );
    };
}
