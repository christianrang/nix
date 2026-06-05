{ inputs, self, ... }: {
  flake.modules.neovim = { pkgs, ... }: { programs.neovim.enable = true; };
  perSystem = { pkgs, self', ... }: { };
}
