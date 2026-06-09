{ inputs, self, lib, config, ... }: {
  flake.modules.desktop = { pkgs, ... }: {
  options = {
    imports = [
      self.modules.catppuccinCursor
    ];
    desktopConfig = {
      windowManager = lib.mkOption {
        type = lib.types.enum [ "hyprland" "i3" ];
        default = "hyprland";
        description = "Choose your window manager.";
      };
    };
  };

  config = lib.mkIf pkgs.stdenv.isLinux (lib.mkMerge [
    { }
    (lib.mkIf (config.desktopConfig.windowManager == "hyprland") {
      hyprlandModule.enable = true;
    })
    (lib.mkIf (config.desktopConfig.windowManager == "i3") {
      i3Module.enable = true;
    })
  ]);
};
}
