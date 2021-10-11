{
  description = "A Hydra jobset to build Nix across many platforms";

  inputs.nixpkgs.url = github:nixos/nixpkgs;
  inputs.nix.url = github:nixos/nix;
  inputs.flake-utils.url = github:numtide/flake-utils;

  outputs = { self, nixpkgs, nix, flake-utils }:
    flake-utils.lib.eachSystem flake-utils.lib.allSystems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ nix.overlay ];
        };
      in
      {
        hydraJobs = {
          nix = pkgs.nix;
        };
      });
}
