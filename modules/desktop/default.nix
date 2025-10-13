{ lib, config, ... }:

{
  imports = [ ./cursors.nix ./i3 ./hyprland ];
  options = {
    desktopConfig = {
      windowManager = lib.mkOption {
        type = lib.types.enum [ "hyprland" "i3" ];
        default = "hyprland";
        description = "Choose your window manager.";
      };
    };
  };

  config = lib.mkMerge [
    { }
    (lib.mkIf (config.desktopConfig.windowManager == "hyprland") {
      hyprlandModule.enable = true;
    })
    (lib.mkIf (config.desktopConfig.windowManager == "i3") {
      i3Module.enable = true;
    })
  ];
}
