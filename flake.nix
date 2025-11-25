{
    # https://www.youtube.com/watch?v=7QLhCgDMqgw
    description = "hyprland on NixOS";
    inputs = {
        nixpks.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager, ... }: {
        nixosConfigurations.louis-nixos = nixpkgs.lib.nixosSystem {
            modules = [
                ./configuration.nix
                home-manager.nixosModules.home-manager {
                    home-manager = {
                        useUserPackages = true;
                        useGlobalPkgs = true;
                        users.louis = import ./home.nix;
                    };
                }
            ];
        };
    };
}
