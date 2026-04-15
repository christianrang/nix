{
  description = "Christian Rang's home-manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Private repo — set flake = false if it's not a flake itself
    # private-repo = {
    #   url = "github:your-org/private-repo";
    #   flake = false;
    # };
  };

  outputs = { nixpkgs, home-manager, ... }: let
    mkHome = system: module: home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [ module ];
      # extraSpecialArgs = { inherit private-repo; };
    };
  in {
    homeConfigurations = {
      "christian.rang" = mkHome "aarch64-darwin" ./nix/hosts/runreveal-macbook/home.nix;
      "root"           = mkHome "x86_64-linux"   ./nix/hosts/dev/home.nix;
    };
  };
}
