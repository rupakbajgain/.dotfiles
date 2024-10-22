{
  description = "My config";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

  outputs = { self, nixpkgs }:
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
        specialArgs = {inherit system;};
        modules = [./system/configuration.nix];
      };
    };
  };
}
