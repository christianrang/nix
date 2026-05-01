{ pkgs, lib, ... }: lib.mkIf pkgs.stdenv.isLinux {
  home.packages = with pkgs; [ zathura ];

  home.file = {
    ".config/zathura/" = {
      source = ../../../../../zathura/.config/zathura;
      recursive = true;
    };
  };
}
