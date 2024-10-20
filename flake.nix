{
  description = "river2056_Darwin_system_flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

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
      ...
    }:

    let
      system = "aarch64-darwin";
      pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${system};
      configuration =
        inputs@{
          pkgs,
          pkgs-stable,
          config,
          ...
        }:
        {
          nixpkgs.config.allowUnfree = true;
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages =
            (with pkgs; [
              # shell
              zsh

              # editor
              neovim

              # utils
              git
              wget
              curl
              lftp
              netcat-gnu
              zoxide
              eza
              yazi
              tree
              bat
              fzf
              fd
              ripgrep
              htop
              delta
              lazygit
              luarocks-nix
              jq
              yq
              gnumake
              mkalias

              # build systems
              maven
              gradle
              docker
              ant

              # languages
              python3
              go
              jdk17
              zig
              lua5_1
              nodejs
              bun

              # fonts
              meslo-lgs-nf
              fira-code-nerdfont

              #nixfmt
              nixfmt-rfc-style
            ])
            ++ (with pkgs-stable; [
              # editor
              vim

              # utils
              tmux
              tmuxinator
            ]);

          environment.shells = with pkgs; [ zsh ];

          homebrew = {
            enable = true;
            brews = [
              "zsh-autosuggestions"
              "zsh-syntax-highlighting"
              "powerlevel10k"
            ];
            casks = [
              "wezterm"
              "raycast"
            ];
            onActivation.cleanup = "zap";
            onActivation.autoUpdate = true;
            onActivation.upgrade = true;
          };

          system.defaults = {
            dock.autohide = true;
            NSGlobalDomain.AppleInterfaceStyle = "Dark";
          };

          system.activationScripts.applications.text =
            let
              env = pkgs.buildEnv {
                name = "system-applications";
                paths = config.environment.systemPackages;
                pathsToLink = "/Applications";
              };
            in
            pkgs.lib.mkForce ''
              # Set up applications.
              echo "setting up /Applications..." >&2
              rm -rf /Applications/Nix\ Apps
              mkdir -p /Applications/Nix\ Apps
              find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
              while read src; do
                  app_name=$(basename "$src")
                  echo "copying $src" >&2
                  ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
              done
            '';

          # Auto upgrade nix package and the daemon service.
          services.nix-daemon.enable = true;
          # nix.package = pkgs.nix;

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Create /etc/zshrc that loads the nix-darwin environment.
          programs.zsh.enable = true; # default shell on catalina
          # programs.fish.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "${system}"; # "aarch64-darwin";
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."river2056" = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit pkgs-stable;
        };
        modules = [
          configuration
          inputs.nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;

              # User owning the Homebrew prefix
              user = "tungchinchen";
              # Optional: Declarative tap management
              taps = {
                "homebrew/homebrew-core" = inputs.homebrew-core;
                "homebrew/homebrew-cask" = inputs.homebrew-cask;
              };

              # Automatically migrate existing Homebrew installations
              # autoMigrate = true;
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."river2056".pkgs;
    };
}
