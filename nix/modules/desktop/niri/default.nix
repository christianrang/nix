{ self, inputs, ... }: {
  flake.modules.niriModule = { pkgs, lib, config, ... }: {
    options = { niriModule.enable = lib.mkEnableOption "Enable Niri Module"; };

    config = lib.mkIf config.niriModule.enable {
      home.packages = with pkgs; [ niri ];
    };

  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        spawn-at-startup = [ (lib.getExe self'.packages.myNoctalia) ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard.xkb.layout = "us,ua";

        layout.gaps = 5;

        binds = {
          "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
          "Mod+Q".close-window = null;
          "Mod+S".spawn-sh =
            "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
        };
      };
    };
  };
}
