{ lib, ... }: {
  flake.modules.hyprlandModule = { pkgs, config, ... }: {
    options = {
      hyprlandModule.enable = lib.mkEnableOption "Enable Hyprland Module";
    };

    config = lib.mkIf config.hyprlandModule.enable {
      home.packages = with pkgs; [
        hyprsunset
        hyprlock
        hypridle
        wofi
        mako
        hyprland
      ];
    };
  };
}
