{
  description = "My config";

  inputs={
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nbfc-linux = {
      url = "github:nbfc-linux/nbfc-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree=true;
    };
  in
  {
    nixosConfigurations={
      myNixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system inputs;};
        modules = [./system/configuration.nix];
      };
    };
  };
}
