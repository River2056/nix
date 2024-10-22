rebuild:
	darwin-rebuild switch --flake ~/nix#river2056
	home-manager switch --flake ~/nix

darwin:
	darwin-rebuild switch --flake ~/nix#river2056

home:
	home-manager switch --flake ~/nix

update:
	nix flake update
