{ pkgs, ... }: {
  home.packages = with pkgs; [ alacritty nerd-fonts.hack ];

  home.file = {
    ".config/alacritty/" = {
      source = ../../alacritty/.config/alacritty;
      recursive = true;
    };
  };
}
