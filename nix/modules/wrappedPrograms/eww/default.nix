{ inputs, self, ... }: {
  flake.modules.eww = { pkgs, ... }: { home.packages = with pkgs; [ eww jq ]; };

  perSystem = { ... }: { };
}
