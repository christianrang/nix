{ pkgs, ... }: {
  home.packages = with pkgs; [ ] ++ (lib.optionals (pkgs.stdenv.isLinux) [ bibata-cursors catppuccin-cursors.mochaDark ]);
}
