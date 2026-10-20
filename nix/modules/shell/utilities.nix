{ ... }: {
  flake.modules.utilities = { pkgs, lib, ... }: {
    home.packages = with pkgs;
      [ gh stow rclone mods gum unzip jless ]
      ++ (lib.optionals pkgs.stdenv.isLinux [ kubernetes ]);
  };
}
