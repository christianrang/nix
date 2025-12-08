{ pkgs, ... }: {
  home.packages = with pkgs; [ zathura ];

  home.file = {
    ".config/zathura/" = {
      source = ../../../../../zathura/.config/zathura;
      recursive = true;
    };
  };
}
