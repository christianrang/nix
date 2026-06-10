{ ... }: {
  flake.modules.shell = { pkgs, ... }: {
    home.packages = with pkgs; [ bat jq ];
  };
}
