# set up your environment using nix
1. download nix from the official website: 
```zsh
sh <(curl -L https://nixos.org/nix/install)
```
2. git clone this repo
```zsh
nix-shell -p git --run "git clone "
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
