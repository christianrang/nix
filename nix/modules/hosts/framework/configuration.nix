{ self, inputs, ... }: {

  # This is your system configuration entry-point
  flake.nixosConfigurations.framework = inputs.nixpkgs.lib.nixosSystem {
    modules =
      [ self.nixosModules.frameworkModule self.nixosModules.myHomeManager ];
  };

  # This is your configuration.nix, a place where you configure your system
  # You can place it in a separate file.
  flake.nixosModules.frameworkModule = { pkgs, ... }: {
    home-manager.users.crang = self.homeModules.crangModule;

    imports = [ self.nixosModules.myMachineHardware ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Fingerprint stuff
    services.fprintd.enable = true;
    security.pam.services.sudo.fprintAuth = true;
    security.pam.services.login.fprintAuth = true;

    # ── Bootloader ──────────────────────────────────────────────────────────────
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # ── Networking ───────────────────────────────────────────────────────────────
    networking.hostName = "framework";
    networking.networkmanager.enable = true;

    # ── Locale / Time ────────────────────────────────────────────────────────────
    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";

    # ── Graphics / OpenGL ────────────────────────────────────────────────────────
    hardware.opengl = { enable = true; };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    # ── Hyprland ─────────────────────────────────────────────────────────────────
    programs.hyprland = {
      enable = true;
      xwayland.enable = true; # XWayland for legacy X11 apps
    };

    # XDG portal — required for screen sharing, file pickers, etc.
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };

    # ── Display Manager ──────────────────────────────────────────────────────────
    # greetd + tuigreet is lightweight and Wayland-native
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command =
            "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'start-hyprland'";
          user = "greeter";
        };
      };
    };

    # ── Sound (PipeWire) ─────────────────────────────────────────────────────────
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    programs.zsh.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.crang = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "crang";
      extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
      packages = with pkgs; [
        neovim
        nerd-fonts.hack
        mpd
        brightnessctl
        hyprpaper
      ];
    };

    # ── System Packages ──────────────────────────────────────────────────────────
    environment.systemPackages = with pkgs; [
      # Wayland essentials
      wayland
      wayland-utils
      wl-clipboard
      xwayland

      # Hyprland ecosystem
      waybar # status bar
      wofi # app launcher
      mako # notification daemon
      hyprpaper # wallpaper
      hyprlock # screen locker
      hypridle # idle daemon

      # Terminal
      kitty

      # Utilities
      brightnessctl # backlight control
      playerctl # media keys
      grim # screenshots
      slurp # region select
      swappy # screenshot annotation
      networkmanagerapplet

      # Polkit agent (needed for privilege escalation in GUI)
      polkit_gnome

      # Fonts
      noto-fonts
      noto-fonts-color-emoji
      font-awesome
    ];

    programs._1password.enable = true;

    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "crang" ];
    };

    # ── Polkit ────────────────────────────────────────────────────────────────────
    security.polkit.enable = true;
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
      };
    };

    services.tailscale = { enable = true; };

    # networking.wg-quick.interfaces.wg0 = {
    #   configFile = "/etc/nixos/modules/wireguard/cj-home.conf";
    # };

    # ── Fonts ─────────────────────────────────────────────────────────────────────
    fonts.fontconfig.enable = true;

    # ── Miscellaneous ─────────────────────────────────────────────────────────────
    nixpkgs.config.allowUnfree = true;

    virtualisation.docker.enable = true;

    system.stateVersion = "24.11"; # do not change after first install
  };
}
