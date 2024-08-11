{
  description = "Adoptium OpenJDK Java Mission Control";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/4d10225ee46c0ab16332a2450b493e0277d1741a";

  outputs = { self, nixpkgs }:
  let

    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

  in {

    packages.${system}.default = pkgs.callPackage ./default.nix {};

  };
}
