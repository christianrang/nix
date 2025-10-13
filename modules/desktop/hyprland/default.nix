{ pkgs, lib, config, ... }:
let cfg = config.hyprlandModule;
in {
  options = {
    hyprlandModule.enable = lib.mkEnableOption "Enable Hyprland Module";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprsunset
      hyprlock
      hypridle
      wofi
      mako
      eww
      hyprland
    ];
  };
}
