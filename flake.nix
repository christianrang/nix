outputs = { nixpkgs, home-manager, ... }:
let
  version = "1.25.0";
  goverlay = final: prev: {
    go = prev.go.overrideAttrs
      (old: {
        inherit version;
        src = final.fetchurl
          {
            url = "https://go.dev/dl/go${version}.src.tar.gz";
            sha256 = "4bd01e91297207bfa450ea40d4d5a93b1b531a5e438473b2a06e18e077227225";
          };
      });
  };
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
  };
  gopkgs = import nixpkgs {
    inherit system; overlays = [ goverlay ];
  };
in
{
  homeConfigurations."user" = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    # Specify your home configuration modules here, for example,
    # the path to your home.nix.
    modules = [ ./home.nix ];
    extraSpecialArgs = { inherit gopkgs; };

    # Optionally use extraSpecialArgs
    # to pass through arguments to home.nix
  };
};
