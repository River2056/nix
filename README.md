# set up your environment using nix
1. download nix from the official website: 
```zsh
sh <(curl -L https://nixos.org/nix/install)
```
2. git clone this repo
```zsh
nix-shell -p git --run "git clone git@github.com:River2056/nix.git"
```

3. run command:
```zsh
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/nix#river2056
```

when need to rebuild:
```zsh
darwin-rebuild switch --flake ~/nix#river2056
```

update flakes and system packages:
```zsh
nix flake update
darwin-rebuild switch --flake ~/nix#river2056
```

list all installed packages:
```zsh
nix-store -q --references /var/run/current-system/sw | cut -d'-' -f2-
```

alternatively, you can list most of the programs you have installed by running
```zsh
ls /run/current-system/sw/bin/
```
and
```zsh
ls ~/.nix-profile/bin/
```
