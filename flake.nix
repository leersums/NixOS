{
  description = "Flakes configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
  };

  outputs = { self, nixpkgs, home-manager }:
    {
      security.sudo = {
        enable = true;
        wheelNeedsPassword = true;
      };
      nixosConfigurations = {
        keoldale = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./configuration.nix
                      ./hosts/ThinkYoga.nix
                      home-manager.nixosModules.home-manager
                      {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        #home-manager.users.leersums = import ./home/leersums.nix;
                        # home-manager.users.leersumta = import ./home/leersumta.nix;
                        # Optionally, use home-manager.extraSpecialArgs to pass
                        # arguments to home.nix
                      }
                    ];
        };
        thurso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./configuration.nix
                      ./hosts/HPZ640.nixi
                    
                    ];
        };
      };
     };
}
