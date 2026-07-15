{ ... }: {
  flake.modules.zathura = { pkgs, ... }: {
    home.packages = with pkgs; [ zathura ];

    home.file = {
      ".config/zathura/" = {
        enable = true;
        source = ./.config/zathura;
        recursive = true;
      };
    };
  };

  perSystem = { pkgs, ... }: {
    apps.zathura = {
      type = "app";
      program = "${pkgs.writeShellScript "zathura" ''
        ln -sf ${./.config/zathura} "$HOME/.config/zathura"
        exec ${pkgs.lib.getExe pkgs.zathura} "$@"
      ''}";
    };
  };
}
