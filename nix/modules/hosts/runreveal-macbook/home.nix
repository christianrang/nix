{ self, inputs, ... }:
let homeDirectory = "/Users/christian.rang";
in {
  flake.homeConfigurations.runreveal-macbook =
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        system = "aarch64-darwin";
        overlays = [ self.overlays.braveDarwin ];
      };
      modules = [ self.homeModules.runrevealMacbookModule ];
    };

  flake.homeModules.runrevealMacbookModule = { pkgs, ... }: {
    imports = [
      self.modules.shell
      self.modules.desktop
      self.modules.mac
      self.modules.jujutsu
      inputs.runreveal-dots.homeManagerModules.default
    ];

    runreveal.enable = true;

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

      podman

      nodejs
    ];

    programs.home-manager.enable = true;

    programs.go = {
      enable = true;
      env = {
        GOPRIVATE = [ "github.com/christianrang" ];
        GOPATH = "${homeDirectory}/progdev/go";
      };
    };
  };
}
