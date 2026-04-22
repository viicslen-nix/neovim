{
  inputs,
  self,
  ...
} @ args: {
  perSystem = {
    config,
    system,
    pkgs,
    lib,
    ...
  }: let
    sharedPackages = inputs.packages.packages.${system};

    # Create nixpkgs with unfree allowed for nvf
    pkgsUnfree = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
      # Or be more specific:
      # config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
      #   "intelephense"
      # ];
    };
  in {
    packages = {
      mcphub-nvim = inputs.mcphub-nvim.packages."${system}".default;
      mcp-hub = sharedPackages.nvim.mcp-hub;
      laravel-nvim = sharedPackages.nvim.laravel-nvim;
      neotest-pest = sharedPackages.nvim.neotest-pest;
      worktrees-nvim = sharedPackages.nvim.worktrees-nvim;

      default =
        (inputs.nvf.lib.neovimConfiguration {
          pkgs = pkgsUnfree;
          modules = [
            {
              # Pass the custom packages to the nvf configuration
              _module.args = {
                inherit
                  (config.packages)
                  laravel-nvim
                  neotest-pest
                  mcphub-nvim
                  mcp-hub
                  worktrees-nvim
                  ;
              };
            }
            ./config
          ];
        })
        .neovim;
    };
  };
}
