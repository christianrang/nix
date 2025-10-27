{
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf (pkgs.stdenv.isDarwin) {
    # Ensure aerospace package installed
    home.packages = [ pkgs.aerospace ];
    home.file = {
      ".config/aerospace/" = {
        source = ../../../aerospace/.config/aerospace;
        recursive = true;
      };
    };
  };
}
