{
  description = "Flakes configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    {
      nixosConfigurations = {
        keoldale = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./configuration.nix
                      home-manager.nixosModules.home-manager
                      {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.leersums = import ./home/leersums.nix;
                        home-manager.users.leersumta = import ./home/leersumta.nix;
                        # Optionally, use home-manager.extraSpecialArgs to pass
                        # arguments to home.nix
                      }
                    ];
        };
        thurso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./configuration.nix];
        };
      };
    };
}
