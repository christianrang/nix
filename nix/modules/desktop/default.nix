{ self, ... }: {
  flake.modules.desktop = { pkgs, ... }: {
    imports = [ self.modules.catppuccinCursor self.modules.eww ];
    home.packages = with pkgs; [
      hyprsunset
      hyprlock
      hypridle
      wofi
      mako
      hyprland
    ];
  };
}
