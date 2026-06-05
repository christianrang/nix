{ inputs, self, ... }: {
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
  perSystem = { pkgs, self', ... }: { };
}
