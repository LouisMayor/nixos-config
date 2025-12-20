{
    # https://www.youtube.com/watch?v=7QLhCgDMqgw
    description = "hyprland on NixOS";
    inputs = {
        nixpks.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
		nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
	};

    outputs = { nixpkgs, home-manager, nix-flatpak, ... }: {
        nixosConfigurations.louis-nixos = nixpkgs.lib.nixosSystem {
            modules = [
                ./configuration.nix
                home-manager.nixosModules.home-manager {
                    home-manager = {
                        useUserPackages = true;
                        useGlobalPkgs = true;
                        users.louis.imports = [
							nix-flatpak.homeManagerModules.nix-flatpak
							./home.nix
						];
                    };
                }
            ];
        };
    };
}
