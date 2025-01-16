{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = import ./nix/overlays.nix;
        };
      in
      {
        devShells.default = import ./nix/shell.nix {
          inherit pkgs;
          ci = false;
        };
        devShells.ci = import ./nix/shell.nix {
          inherit pkgs;
          ci = true;
        };
      }
    );
}
