{ pkgs, ... }: {
  home.packages = with pkgs; [ ghostty alacritty nerd-fonts.hack ];

  home.file = {
    ".config/alacritty/" = {
      source = ../../alacritty/.config/alacritty;
      recursive = true;
    };
  };
}
