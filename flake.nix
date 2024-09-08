{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-rk3588.url = "github:ryan4yin/nixos-rk3588?ref=main";
  };

  outputs = { self, nixpkgs, nixos-rk3588 }@inputs: {
    nixosConfigurations.nixrouter = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {
        inherit inputs;
        rk3588 = {
          inherit nixpkgs;
          pkgsKernel = import nixpkgs {
            system = "aarch64-linux";
          };
        };
      };

      modules = [
        nixos-rk3588.nixosModules.orangepi5plus.core
        ./configuration.nix
      ];
    };
  };
}
