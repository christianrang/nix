{ ... }: {
  flake.modules.braveModule = { lib, config, ... }: {
    options = {
      braveModule.theme = lib.mkOption {
        type = lib.types.enum [ "catppuccin-mocha" ];
        default = "catppuccin-mocha";
      };
    };

    config = {
      # TODO: some of the configuration only needs to be set on linux
      programs.brave = {
        enable = true;
        commandLineArgs =
          [ "--enable-features=TouchpadOverscrollHistoryNavigation" ];
        extensions = [
          "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
        ] ++ (lib.optionals (config.braveModule.theme == "catppuccin-mocha") [
          "bkkmolkhemgaeaeggcmfbghljjjoofoh" # Catppuccin
        ]);
      };
    };
  };

  perSystem = { ... }: { };
}
