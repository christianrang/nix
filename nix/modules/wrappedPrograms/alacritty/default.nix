{ inputs, self, ... }: {
  flake.modules.alacritty = { pkgs, ... }: {
    programs.alacritty.enable = true;
  };
  perSystem = { pkgs, self', ... }: { };
}
