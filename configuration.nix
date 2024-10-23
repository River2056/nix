{
  self,
  nixpkgs,
  pkgs,
  pkgs-stable,
  config,
  system,
  ...
}:
{
  imports = [
    (import ./shells/zsh.nix {
      inherit config pkgs;
      enabled = true;
    })
  ];
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    (with pkgs; [
      # shell
      zsh

      #utils
      mkalias

      # fonts
      meslo-lgs-nf
      fira-code-nerdfont

    ])
    ++ (with pkgs-stable; [
      # editor
      vim

      # utils
      tmux
      tmuxinator
      wget
      curl
      sshpass
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
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "${system}"; # "aarch64-darwin";
}
