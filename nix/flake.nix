{
  description = "Bonfire NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosModules = {
	  default = ./bonfire-config.nix;
	  bonfire = ./bonfire-config.nix;
	};
  };
}