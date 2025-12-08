{ pkgs, ... }: {
  home.packages = with pkgs; [ alacritty nerd-fonts.hack ] ++ (lib.optionals (pkgs.stdenv.isLinux) [ ghostty ]);

  home.file = {
    ".config/alacritty/" = {
      source = ../../../alacritty/.config/alacritty;
      recursive = true;
    };
  };
}
