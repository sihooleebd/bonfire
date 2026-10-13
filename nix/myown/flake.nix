{
  description = "System Configuration powered by Bonfire NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    bonfire = {
      url = "github:sihooleebd/bonfire?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fcitx5-lotus = {
      url = "github:LotusInputMethod/fcitx5-lotus";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, zen-browser, fcitx5-lotus, bonfire, ... }@inputs: {
    nixosConfigurations = {
    nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          unstable = import nixpkgs-unstable {
            system = "x86_64-linux";
          };
        };
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
          bonfire.nixosModules.default

          ({ pkgs, ... }: {
            environment.systemPackages = [
            zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
            ];
          })
        ];
      };
    };
  };
}
