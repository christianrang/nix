{ config, lib, pkgs, ... }:

let
  isI3 = false;
  isLuaDev = true;
  theme_catppuccin-mocha = "catppuccin-mocha";
  theme = theme_catppuccin-mocha;

in
{
  home.username = "crang";
  home.homeDirectory = "/home/crang";

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
    pkgs.rclone
    pkgs.tailscale
    pkgs.stow
    pkgs.fd
    pkgs.gh
    pkgs.ripgrep
    pkgs.bat
    pkgs.fzf
    pkgs.zathura
    pkgs.kubernetes
    pkgs.zsh-powerlevel10k
    pkgs.alacritty
    pkgs.obsidian
    pkgs.nerd-fonts.hack
    pkgs.tmux
    pkgs.gcc
    pkgs.mods
    pkgs.gum
    pkgs.jq
    pkgs.gh
    pkgs.acpi
    pkgs.alsa-utils
    pkgs.tealdeer
    pkgs.unzip
    pkgs.wofi
    pkgs.hyprsunset
    pkgs.hyprlock
    pkgs.hypridle
    pkgs.socat
    pkgs.eww
    pkgs.brightnessctl
    pkgs.mako
    pkgs.neovim-remote

    pkgs.cargo

    # Python and debugging package to work with nvim-dap
    (pkgs.python313.withPackages (python-pkgs: [
      python-pkgs.debugpy
    ]))

    pkgs.playerctl
    pkgs.nodejs
    pkgs.discord
    pkgs.slack
    pkgs.bibata-cursors
    pkgs.catppuccin-cursors.mochaDark
    pkgs.jless
  ] ++ (lib.optionals isLuaDev [
    pkgs.lua-language-server
    pkgs.stylua
  ]) ++ (lib.optionals isI3 [
    pkgs.polybar
    pkgs.nitrogen
    pkgs.rofi
    pkgs.picom
  ]);

  home.file = {
    ".zshrc".source = zsh/.zshrc;
    ".i3/config".source = i3/.i3/config;
    ".gitconfig".source = git/.gitconfig;
    ".config/tmux/tmux.conf".source = tmux/.config/tmux/tmux.conf;
    ".config/alacritty/" = {
      source = alacritty/.config/alacritty;
      recursive = true;
    };

    ".config/nitrogen/nitrogen.cfg" = {
      enable = isI3;
      source = nitrogen/.config/nitrogen/nitrogen.cfg;
    };

    ".config/picom.conf" = {
      source = picom/.config/picom.conf;
      enable = isI3;
    };

    ".config/rofi/config.rasi" = {
      enable = isI3;
      source = rofi/.config/rofi/config.rasi;
    };

    ".local/share/rofi/themes/" = {
      enable = isI3;
      source = rofi/.local/share/rofi/themes;
      recursive = true;
    };

    ".config/polybar/" = {
      enable = isI3;
      source = polybar/.config/polybar;
      recursive = true;
    };

    ".config/nvim/" = {
      enable = false;
      source = nvim/.config/nvim;
      recursive = true;
    };

    ".config/zathura/" = {
      source = zathura/.config/zathura;
      recursive = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvr -s";
    NIXOS_OZONE_WL = "1";
  };

  programs.home-manager.enable = true;

  # programs.zsh = {
  #     enable = true;
  #     oh-my-zsh = {
  #         enable = true;
  #     };
  # };

  programs.neovim.enable = true;
  programs.git.enable = true;

  programs.brave = {
    enable = true;
    commandLineArgs = [
      "--enable-features=TouchpadOverscrollHistoryNavigation"
    ];
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
    goPath = "progdev/go";
    goPrivate = [ "github.com/christianrang" ];
  };
}
