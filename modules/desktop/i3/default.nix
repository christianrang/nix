{ lib, config, pkgs, ... }:
let cfg = config.i3Module;
in {
  options = { i3Module.enable = lib.mkEnableOption "Enable Module"; };

  config = lib.mkIf cfg.enable {
    #config contents
    home.packages = [ pkgs.polybar pkgs.nitrogen pkgs.rofi pkgs.picom ];

    home.file = {
      ".i3/config".source = ../../../i3/.i3/config;

      ".config/nitrogen/nitrogen.cfg" = {
        source = ../../../nitrogen/.config/nitrogen/nitrogen.cfg;
      };

      ".config/picom.conf" = { source = ../../../picom/.config/picom.conf; };

      ".config/rofi/config.rasi" = {
        source = ../../../rofi/.config/rofi/config.rasi;
      };

      ".local/share/rofi/themes/" = {
        source = ../../../rofi/.local/share/rofi/themes;
        recursive = true;
      };

      ".config/polybar/" = {
        source = ../../../polybar/.config/polybar;
        recursive = true;
      };
    };
  };
}
