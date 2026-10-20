{ ... }: {
  flake.modules.pass = { pkgs, ... }: {
    home.packages = with pkgs; [ pass gnupg ];
  };
}
