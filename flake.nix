{
  description = "river2056_Darwin_system_flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # install specific packages from a specific commit example
    # tmux 3.2
    # nixpkgs-pkg-tmux.url = "github:nixos/nixpkgs/9f8610e5dbb0b437b4f4ac9d65057cf7553218f2";

    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;

    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      # change user according to your machine if necessary
      nixProfile = "river2056";
      user = "kevintung";
      system = "aarch64-darwin";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${system};
      profileDir = "/Users/${user}/.nix-profile";
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations.${nixProfile} = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit pkgs;
          inherit pkgs-stable;
          inherit nixpkgs;
          inherit self;
          inherit system;
        };
        modules = [
          ./configuration.nix
          inputs.nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;

              # User owning the Homebrew prefix
              user = "kevintung";
              # Optional: Declarative tap management
              taps = {
                "homebrew/homebrew-core" = inputs.homebrew-core;
                "homebrew/homebrew-cask" = inputs.homebrew-cask;
              };

              # Automatically migrate existing Homebrew installations
              autoMigrate = true;
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations.${nixProfile}.pkgs;

      homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit nixpkgs user profileDir;
        };
        modules = [
          ./home.nix
        ];
      };
    };
}
