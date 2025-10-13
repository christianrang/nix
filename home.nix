{ lib, pkgs, config, ... }:

let
  theme_catppuccin-mocha = "catppuccin-mocha";
  theme = theme_catppuccin-mocha;
  homeDirectory = "/home/crang";

in {
  imports = [
    ./modules/development
    ./modules/desktop/cursors.nix
    ./modules/desktop
    ./modules/shell
    ./modules/terminal
  ];

  home.username = "crang";
  home.homeDirectory = homeDirectory;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.tailscale
    pkgs.zathura
    pkgs.obsidian
    pkgs.nerd-fonts.hack
    pkgs.gcc
    pkgs.acpi
    pkgs.alsa-utils
    pkgs.socat
    pkgs.brightnessctl

    pkgs.signal-desktop
    pkgs.discord
    pkgs.slack

    pkgs.devenv
    pkgs.direnv

    pkgs.playerctl
    pkgs.nodejs
  ];

  home.file = {
    ".config/zathura/" = {
      source = zathura/.config/zathura;
      recursive = true;
    };
  };

  home.sessionVariables = { NIXOS_OZONE_WL = "1"; };

  programs.home-manager.enable = true;

  programs.brave = {
    enable = true;
    commandLineArgs =
      [ "--enable-features=TouchpadOverscrollHistoryNavigation" ];
    extensions = [
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
    ] ++ (lib.optionals (theme == theme_catppuccin-mocha) [
      "bkkmolkhemgaeaeggcmfbghljjjoofoh" # Catppuccin
    ]);
  };

  programs.chromium = {
    enable = true;
    extensions = [
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
    ] ++ (lib.optionals (theme == theme_catppuccin-mocha) [
      "bkkmolkhemgaeaeggcmfbghljjjoofoh" # Catppuccin
    ]);
    commandLineArgs = [
      "--enable-features=TouchpadOverscrollHistoryNavigation,UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
  };

  programs.go = {
    enable = true;
    env = {
      GOPRIVATE = [ "github.com/christianrang" ];
      GOPATH = "${homeDirectory}/progdev/go";
    };
  };
}
