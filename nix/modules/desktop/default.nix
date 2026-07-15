{ lib, ... }: {
  flake.modules.desktop = { self, pkgs, config, ... }: {
    imports = [
      self.modules.catppuccinCursor
      self.modules.alacritty
      self.modules.eww
      self.modules.hyprlandModule
      self.modules.niriModule
      self.modules.braveModule
      self.modules.chromiumModule
      self.modules.zathura
    ];

    options = {
      desktopConfig.windowManager = lib.mkOption {
        type = lib.types.enum [ "hyprland" "niri" ];
        default = "hyprland";
      };
    };

    config = lib.mkIf pkgs.stdenv.isLinux (lib.mkMerge [
      (lib.mkIf (config.desktopConfig.windowManager == "hyprland") {
        hyprlandModule.enable = true;
      })
      (lib.mkIf (config.desktopConfig.windowManager == "niri") {
        niriModule.enable = true;
      })
    ]);
  };
}

