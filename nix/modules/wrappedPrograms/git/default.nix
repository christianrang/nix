{ inputs, self, ... }: {
  flake.modules.git = { pkgs, ... }: {
    home.packages = with pkgs; [ git ];

    home.file = { ".gitconfig".source = ./.gitconfig; };
  };

  perSystem = { pkgs, ... }: {
    apps.git = {
      type = "app";
      program = "${pkgs.writeShellScript "git" ''
        ln -sf ${./.gitrc} "$HOME/.gitconfig"
        exec ${pkgs.lib.getExe pkgs.git} "$@"
      ''}";
    };
  };
}
