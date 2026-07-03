{ self, inputs, pkgs, lib, ... }:
let
  theme_catppuccin-mocha = "catppuccin-mocha";
  theme = theme_catppuccin-mocha;
  homeDirectory = "/home/crang";
in {

  # This is your standalone home-manager configuration, meant to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations.crang =
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
      modules = [
        self.homeModules.crangModule
        {
          home.username = "crang";
          home.homeDirectory = "/home/crang";
        }
      ];
    };

  # This is your home.nix, your module where you configure home-manager
  # It's imported both in standalone configuration above, and in your nixos configuration
  flake.homeModules.crangModule = { pkgs, ... }: {
    imports = [
      self.modules.shell
      self.modules.desktop
      self.modules.neovim
      self.modules.personal-scripts
      self.modules.alacritty
      self.modules.tmux
      self.modules.zsh
      self.modules.git
    ];

    # desktopConfig.windowManager = "niri";

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

    home.packages = with pkgs;
      [
        obsidian
        socat

        devenv
        direnv

        nodejs
      ] ++ (lib.optionals pkgs.stdenv.isLinux [
        alsa-utils
        acpi
        brightnessctl

        playerctl
        signal-desktop
        discord
        zathura
      ]);

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
  };

}
