{ ... }: {
  flake.modules.alacritty = { pkgs, ... }: {
    home.packages = with pkgs;
      [ alacritty nerd-fonts.hack ]
      ++ (lib.optionals (pkgs.stdenv.isLinux) [ ghostty ]);

    home.file = {
      ".config/alacritty/" = {
        source = ./.config/alacritty;
        recursive = true;
      };
    };
  };

  perSystem = { pkgs, ... }: {
    apps.alacritty = {
      type = "app";
      program = "${pkgs.writeShellScript "alacritty" ''
        mkdir -p "$HOME/.config"
        ln -sf ${./.config/alacritty} "$HOME/.config/alacritty"
        exec ${pkgs.lib.getExe pkgs.alacritty} "$@"
      ''}";
    };
  };
}
