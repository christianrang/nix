{ pkgs, ... }:

let
  homeDirectory = "/root";
in {
  imports = [
    ../../modules/development
    ../../modules/desktop
    ../../modules/shell
    ../../modules/terminal
  ];

  # desktopConfig.windowManager = "i3";

  home.username = "root";
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
    socat

    devenv
    direnv

    nodejs
  ];

  # TODO: This should be only on linux
  home.sessionVariables = { NIXOS_OZONE_WL = "1"; };

  programs.home-manager.enable = true;

  programs.go = {
    enable = true;
    env = {
      GOPRIVATE = [ "github.com/christianrang" ];
      GOPATH = "${homeDirectory}/progdev/go";
    };
  };
}

