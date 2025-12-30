{ lib, pkgs, ... }:

let
  theme_catppuccin-mocha = "catppuccin-mocha";
  theme = theme_catppuccin-mocha;
  homeDirectory = "/Users/christian.rang";

  isLinux = pkgs.stdenv.isLinux;

  moveMe = true;
in {
  imports = [
    ../../modules/development
    ../../modules/desktop
    ../../modules/shell
    ../../modules/terminal
  ];

  # desktopConfig.windowManager = "i3";

  home.username = "christian.rang";
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

  home.packages = with pkgs; [
    obsidian
    socat

    slack

    devenv
    direnv

    nodejs

  ] ++ (lib.optionals isLinux [
    alsa-utils
    acpi
    brightnessctl

    playerctl
    signal-desktop
    discord
  ] ++ (lib.optionals moveMe [
    # Temporary add for runreveal work
    google-chrome
  ]));

  # TODO: This should be only on linux
  home.sessionVariables = { NIXOS_OZONE_WL = "1"; };

  programs.home-manager.enable = true;

  # TODO: some of the configuration only needs to be set on linux
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
    enable = pkgs.stdenv.isLinux;
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
