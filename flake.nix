{
  description = "The package manager for the Lua programming language.";

  # To make user overrides of the nixpkgs flake not take effect
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  # https://nixos.wiki/wiki/Flakes#Using_flakes_project_from_a_legacy_Nix
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  outputs = { self
    , nixpkgs
    , flake-utils
    , flake-compat
  }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in rec {
      devShell = pkgs.mkShell {
        buildInputs = [
          pkgs.luajit
        ];
      };
    }
  );
}
