{
  pkgs ? import <nixpkgs> { },
}:
{
  capacities = pkgs.callPackage ./capacities.nix { };
}
