{ config, lib, pkgs, ... }:

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
  	pkgs.stow
  	pkgs.brave
	pkgs.fd
	pkgs.gh
	pkgs.ripgrep
	pkgs.bat
	pkgs.fzf
	pkgs.rofi
	pkgs.zathura
	pkgs.kubernetes
	pkgs.zsh-powerlevel10k
	pkgs.kitty
	pkgs.alacritty
	pkgs.obsidian
	pkgs.nerd-fonts.hack
	pkgs.nitrogen
	pkgs.polybar
	pkgs.picom
	pkgs.tmux
	pkgs.gcc
	pkgs.mods
	pkgs.gum
	pkgs.jq
	pkgs.gh
	pkgs.acpi
	pkgs.alsa-utils
    pkgs.tealdeer
    pkgs.wofi
    pkgs.hyprsunset
    pkgs.socat
    pkgs.playerctl
    pkgs.go
    pkgs.nodejs
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".zshrc".source = zsh/.zshrc;
    ".i3/config".source = i3/.i3/config;
    ".gitconfig".source = git/.gitconfig;
    ".config/tmux/tmux.conf".source = tmux/.config/tmux/tmux.conf;
    ".config/alacritty/" = {
    	source = alacritty/.config/alacritty;
    	recursive = true;
    };
    ".config/nitrogen/nitrogen.cfg".source = nitrogen/.config/nitrogen/nitrogen.cfg;
    ".config/picom.conf".source = picom/.config/picom.conf;

    ".config/rofi/config.rasi".source = rofi/.config/rofi/config.rasi;
    ".local/share/rofi/themes/" = {
    	source = rofi/.local/share/rofi/themes;
    	recursive = true;
    };

    ".config/polybar/" = {
    	source = polybar/.config/polybar;
    	recursive = true;
    };

    ".config/nvim/" = {
    	source = nvim/.config/nvim;
    	recursive = true;
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/crang/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
    };
  };
  programs.neovim.enable = true;
  programs.git.enable = true;
}
