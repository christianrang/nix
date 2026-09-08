{ inputs, self, ... }: {
  flake.modules.jujutsu = { pkgs, ... }: {
    home.packages = with pkgs; [ jujutsu ];

    #   home.file = {
    #     ".gitconfig".source = ./.gitconfig;
    #   };
    # };
    #
    # perSystem = { pkgs, ... }: {
    #   apps.git = {
    #     type = "app";
    #     program = "${pkgs.writeShellScript "jujutsu" ''
    #       ln -sf ${./.gitrc} "$HOME/.gitconfig"
    #       exec ${pkgs.lib.getExe pkgs.git} "$@"
    #     ''}";
    #   };
  };
}
