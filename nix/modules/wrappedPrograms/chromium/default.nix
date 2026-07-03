{ ... }: {
  flake.modules.chromiumModule = { pkgs, lib, config, ... }: {
    options = {
      chromiumModule.theme = lib.mkOption {
        type = lib.types.enum [ "catppuccin-mocha" ];
        default = "catppuccin-mocha";
      };
    };

    config = {
      programs.chromium = {
        enable = pkgs.stdenv.isLinux;
        extensions = [
          "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
        ] ++ (lib.optionals (config.chromiumModule.theme == "catppuccin-mocha")
          [
            "bkkmolkhemgaeaeggcmfbghljjjoofoh" # Catppuccin
          ]);
        commandLineArgs = [
          "--enable-features=TouchpadOverscrollHistoryNavigation,UseOzonePlatform"
          "--ozone-platform=wayland"
        ];
      };
    };
  };

  perSystem = { ... }: { };
}
