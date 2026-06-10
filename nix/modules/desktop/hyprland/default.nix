{ lib, ... }: {
  flake.modules.hyprlandModule = { pkgs, config, ... }: {
    options = { enable = lib.mkEnableOption "Enable Hyprland Module"; };

    config = lib.mkIf config.enable {
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
  };
}
