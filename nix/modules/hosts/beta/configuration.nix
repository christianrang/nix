{ self, inputs, ... }: {

  # The system itself, mirroring how the framework host is declared.
  flake.nixosConfigurations.beta = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.betaModule ];
  };

  # The NixOS configuration, formerly the bare /etc/nixos/configuration.nix.
  flake.nixosModules.betaModule = { config, pkgs, ... }: {
    imports = [ self.nixosModules.betaHardware ];

    # Needed so you can keep rebuilding from this flake after the first switch.
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    time.timeZone = "America/New_York";

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    # GNOME desktop.
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # CUPS to print documents.
    services.printing.enable = true;

    # Sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    users.users."crang" = {
      isNormalUser = true;
      description = "Christian";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [ ];
    };

    programs.firefox.enable = true;

    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true; # Set to false for key-only security
        PermitRootLogin = "prohibit-password";
      };
    };

    # Open port 22 in the firewall.
    networking.firewall.allowedTCPPorts = [ 22 ];

    # This value determines the NixOS release your stateful data is
    # compatible with. Do not change it after the first install.
    # See https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
    system.stateVersion = "26.05";
  };
}
