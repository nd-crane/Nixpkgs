{
  description = "Description for the project";

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    flake-parts,
    pre-commit-hooks,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./pkgs
        flake-parts.flakeModules.easyOverlay
      ];
      systems = ["x86_64-linux"];
      perSystem = {
        self',
        pkgs,
        system,
        ...
      }: {
        formatter = pkgs.alejandra;

        checks = {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              alejandra.enable = true;
              deadnix.enable = true;
              statix.enable = true;
            };
          };
        };

        devShells.default = pkgs.mkShell {
          inherit (self'.checks.pre-commit-check) shellHook;

          buildInputs = [];
        };
      };
    };
}
