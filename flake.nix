{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    packages = {
      url = "github:viicslen-nix/packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf/v0.8";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mcphub-nvim = {
      url = "github:ravitemer/mcphub.nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    flake-parts,
    self,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} (top @ {
      config,
      withSystem,
      moduleWithSystem,
      ...
    }: {
      imports = [
        ./apps.nix
        ./packages.nix
      ];
      systems = [
        "x86_64-linux"
      ];
      perSystem = {
        config,
        pkgs,
        ...
      }: {
        # Provide the default formatter. `nix fmt` in project root
        # will format available files with the correct formatter.
        # P.S: Please do not format with nixfmt! It messes with many
        # syntax elements and results in unreadable code.
        formatter = pkgs.alejandra;

        # Check if codebase is properly formatted.
        # This can be initiated with `nix build .#checks.<system>.nix-fmt`
        # or with `nix flake check`
        checks = {
          nix-fmt = pkgs.runCommand "nix-fmt-check" {nativeBuildInputs = [pkgs.alejandra];} ''
            alejandra --check ${self} < /dev/null | tee $out
          '';
        };

        # Provide a development shell with nix-output-monitor
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nix-output-monitor
            alejandra
          ];
          shellHook = ''
            echo "Development shell with nix-output-monitor available"
            echo "Use 'nom build' or 'nom run' for better build output"
          '';
        };
      };
    });
}
