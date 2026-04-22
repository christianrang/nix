{
  description = "Christian Rang's home-manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    runreveal-dots = {
      url = "git+ssh://git@github.com/christianrang/runreveal-dots";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: let
    mkHome = system: module: home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [ module ];
      extraSpecialArgs = { inherit inputs; };
    };
  in {
    homeConfigurations = {
      "christian.rang" = mkHome "aarch64-darwin" ./nix/hosts/runreveal-macbook/home.nix;
      "root"           = mkHome "x86_64-linux"   ./nix/hosts/dev/home.nix;
    };
  };
}
