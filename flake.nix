{
  description = "Personal Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
    }:
    let
      hosts = import ./hosts;
      inherit (builtins) listToAttrs;
      overlay = final: prev: {
        nvs = prev.buildGoModule rec {
          pname = "nvs";
          version = "1.10.5";

          src = prev.fetchFromGitHub {
            owner = "y3owk1n";
            repo = pname;
            tag = "v${version}";
            sha256 = "sha256-Qp5c2F383Z0MxTtDt3wmLgxiAwfIJWupVDCePrBxNQI=";
          };

          # # Add completion generation
          nativeBuildInputs = [ prev.installShellFiles ];
          postInstall = ''
            export HOME=$TMPDIR
            installShellCompletion --cmd nvs \
              --bash <($out/bin/nvs completion bash) \
              --fish <($out/bin/nvs completion fish) \
              --zsh <($out/bin/nvs completion zsh)
          '';

          vendorHash = "sha256-l2FdnXA+vKVRekcIKt1R+MxppraTsmo0b/B7RNqnxjA=";
        };
      };
    in
    {
      darwinConfigurations = listToAttrs (
        map (host: {
          name = host.hostName;
          value = nix-darwin.lib.darwinSystem {
            specialArgs = {
              inherit host;
              flake = self;
            };
            modules = [
              {
                nixpkgs.overlays = [ overlay ];
              }
              (import ./darwin.nix)
              home-manager.darwinModules.home-manager
              {
                home-manager.backupFileExtension = "backup";
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${host.username} = import ./home/home.nix { inherit host; };
              }
            ];
          };
        }) hosts
      );
    };
}
