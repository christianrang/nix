{ inputs, self, ... }: {
  flake.modules.catppuccinCursor = { pkgs, ... }: {
    home.packages = with pkgs; [ ] ++ (lib.optionals (pkgs.stdenv.hostPlatform.isLinux) [ bibata-cursors catppuccin-cursors.mochaDark ]);
  };
}
