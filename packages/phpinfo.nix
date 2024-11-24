# simple.nix
let
  pkgs = import <nixpkgs> { };
in
  pkgs.stdenv.mkDerivation {
    name = "hello-nix";

    src = ./phpinfo;

    # Use $CC as it allows for stdenv to reference the correct C compiler
    buildPhase = ''
      $CC example.c -o hello_nix
    '';

    installPhase = ''
        mkdir -p $out/bin
        cp hello_nix $out/bin/hello_nix
    '';
  }
