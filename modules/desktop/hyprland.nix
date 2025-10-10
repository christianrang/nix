{ pkgs, ... }: {
  home.packages = with pkgs; [ hyprsunset hyprlock hypridle wofi mako eww ];
}
