{ inputs, self, ... }: {
  flake.modules.tmux = { pkgs, ... }: {
    home.packages = with pkgs; [ tmux ];

    home.file = { ".config/tmux/tmux.conf".source = ./.config/tmux/tmux.conf; };
  };

  perSystem = { pkgs, ... }: {
    apps.tmux = {
      type = "app";
      program = "${pkgs.writeShellScript "tmux" ''
        mkdir -p "$HOME/.config"
        ln -sf ${./.config/tmux} "$HOME/.config/tmux"
        exec ${pkgs.lib.getExe pkgs.tmux} "$@"
      ''}";
    };
  };
}
