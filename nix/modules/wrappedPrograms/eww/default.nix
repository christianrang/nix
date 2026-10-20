{ inputs, self, ... }: {
  flake.modules.eww = { pkgs, lib, ... }: { home.packages = lib.optionals pkgs.stdenv.isLinux [ pkgs.eww pkgs.jq ]; };

  perSystem = { ... }: { };
}
